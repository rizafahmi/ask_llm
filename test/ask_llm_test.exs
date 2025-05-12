defmodule MockReq do
  def post!(_url, _data) do
    %Req.Response{
      status: 200,
      body: %{
        "candidates" => [
          %{
            "content" => %{
              "parts" => [%{"text" => "Hello Elixir! How can I help you today?"}],
              "role" => "model"
            },
            "finishReason" => "STOP",
            "index" => 0
          }
        ]
      }
    }
  end
end

defmodule AskLlmTest do
  use ExUnit.Case
  # doctest AskLlm.Cli
  import ExUnit.CaptureIO

  @help_message """
    Usage: ask_llm [options] <question>

    Options:
      --help, -h       Show this help message
      --model PROVIDER/MODEL    Specify the provider/model to use (default: google/gemini2.5-flash)
  """

  test "generate help message if no args" do
    assert AskLlm.Cli.generate_help_message() == @help_message
  end

  test "display help message if no args" do
    assert capture_io(fn ->
             AskLlm.Cli.main([])
           end) == @help_message <> "\n"
  end

  test "display help message with --help flag" do
    assert capture_io(fn ->
             AskLlm.Cli.main(["--help"])
           end) == @help_message <> "\n"
  end

  test "--message flag send message to llm" do
    message = "Hello, LLM! My name is Elixir"

    response =
      capture_io(fn ->
        AskLlm.Cli.main(["--message", message], MockReq)
      end)

    IO.puts(response)

    assert String.length(response) > 0
    assert String.contains?(response, "Elixir")
  end

  test "--message flag without API_KEY provided" do
    System.put_env("GOOGLE_GEMINI_API_KEY", "")

    assert capture_io(fn ->
             AskLlm.Cli.main(["--message", "Hello, LLM!"])
           end) == "API_KEY is not set.\n"
  end
end
