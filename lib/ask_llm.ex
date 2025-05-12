defmodule AskLlm.Cli do
  def generate_help_message() do
    """
      Usage: ask_llm [options] <question>

      Options:
        --help, -h       Show this help message
        --model PROVIDER/MODEL    Specify the provider/model to use (default: google/gemini2.5-flash)
    """
  end

  def send_message(message) do
    url =
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash-preview-04-17:generateContent?key=#{System.get_env("GOOGLE_GEMINI_API_KEY")}"

    Req.post!(url,
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

  def main(["--message", message]) do
    response = send_message(message)
    content = parse_response(response)
    IO.puts(content)
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

      %Req.Response{} ->
        IO.puts("HTTP Error")
    end
  end
end
