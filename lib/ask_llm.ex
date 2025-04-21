defmodule AskLlm.Cli do
  def generate_help_message() do
    """
      Usage: ask_llm [options] <question>

      Options:
        --help, -h       Show this help message
        --model PROVIDER/MODEL    Specify the provider/model to use (default: anthropic/claude3.7-sonnet)
    """
  end

  def main([]) do
    IO.puts(generate_help_message())
  end

  def main(["--help"]) do
    IO.puts(generate_help_message())
  end
end
