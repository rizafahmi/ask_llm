defmodule AskLlm.Cli do
  @help_message """
    Usage: ask_llm [options] <question>

    Options:
      --help, -h       Show this help message
      --model PROVIDER/MODEL    Specify the provider/model to use (default: anthropic/claude3.7-sonnet)
  """
  def main([]) do
    IO.puts(@help_message)
  end

  def main(["--help"]) do
    IO.puts(@help_message)
  end
end
