defmodule AskLlmTest do
  use ExUnit.Case
  # doctest AskLlm.Cli
  import ExUnit.CaptureIO

  @help_message """
    Usage: ask_llm [options] <question>

    Options:
      --help, -h       Show this help message
      --model PROVIDER/MODEL    Specify the provider/model to use (default: anthropic/claude3.7-sonnet)\n
  """

  test "generate help message if no args" do
    assert capture_io(fn ->
             AskLlm.Cli.main([])
           end) == @help_message
  end

  test "generate help message with --help flag" do
    assert capture_io(fn ->
             AskLlm.Cli.main(["--help"])
           end) == @help_message
  end
end
