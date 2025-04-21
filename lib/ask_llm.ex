defmodule AskLlm.Cli do
  def generate_help_message() do
    """
      Usage: ask_llm [options] <question>

      Options:
        --help, -h       Show this help message
        --model PROVIDER/MODEL    Specify the provider/model to use (default: google/gemini2.5-flash)
    """
  end

  # curl \
  # -X POST \
  # -H "Content-Type: application/json" \
  def send_message(message) do
    url =
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash-preview-04-17:streamGenerateContent=#{System.get_env("GOOGLE_GEMINI_API_KEY")}"

    req =
      Req.Request.new(url: url, method: :post)
      |> Req.Request.put_header("Content-Type", "application/json")

    req
    # Req.post!(url,
    #   json: %{
    #     prompt: message,
    #     temperature: 0.5,
    #     max_output_tokens: 1024,
    #     top_p: 0.8,
    #     top_k: 40
    #   }
    # )
    # |> dbg()
  end

  def main([]) do
    IO.puts(generate_help_message())
  end

  def main(["--help"]) do
    IO.puts(generate_help_message())
  end

  def main(["--message", message]) do
    response = send_message(message)
    IO.puts(response)
  end
end
