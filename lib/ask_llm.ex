defmodule AskLlm.Cli do
  def generate_help_message() do
    """
      Usage: ask_llm [options] <question>

      Options:
        --help, -h       Show this help message
        --model PROVIDER/MODEL    Specify the provider/model to use (default: google/gemini2.5-flash)
    """
  end

  def send_message(message, http_client) do
    url =
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash-preview-04-17:generateContent?key=#{System.get_env("GOOGLE_GEMINI_API_KEY")}"

    http_client.post!(url,
      json: %{
        contents: [%{role: "user", parts: [%{text: message}]}],
        generationConfig: %{
          temperature: 0.5,
          topP: 0.8,
          max_output_tokens: 65536,
          responseMimeType: "text/plain"
        }
      }
    )
  end

  def main([]) do
    IO.puts(generate_help_message())
  end

  def main(["--help"]) do
    IO.puts(generate_help_message())
  end

  def main(["--message", message], http_client \\ Req) do
    response = send_message(message, http_client)

    content = parse_response(response)
    IO.puts(content)
    nil
  end

  def parse_response(response) do
    case response do
      %Req.Response{status: 200, body: body} ->
        content =
          body
          |> Map.get("candidates")
          |> List.first()
          |> Map.get("content")
          |> Map.get("parts")
          |> List.first()
          |> Map.get("text")

        content

      %Req.Response{status: 403, body: body} ->
        response =
          body
          |> Map.get("error")
          |> Map.get("message")

        cond do
          String.contains?(response, "API Key") ->
            IO.write("API_KEY is not set.")
            nil

          true ->
            IO.write("Some other 403 error.")
            nil
        end

      %Req.Response{} ->
        IO.puts("Unknown error")
    end
  end
end
