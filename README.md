# AskLlm

## Example

``` shell
  $ export GOOGLE_GEMINI_API_KEY=yourGeminiAPIkey # OR with .env
  $ ./ask_llm
  $ ./ask_llm --help
  $ ./ask_llm --message "Why the sky is blue?"
  $ ./ask_llm --model anthropic/claude3.7-sonnet --message "Why the sky is blue?"
  $ ./ask_llm --model deepseek/deepseek-r1 --message "Why the sky is blue?"
  $ ./ask_llm --model openai/4o --message "Why the sky is blue?"
  $ ./ask_llm --model azure/4o --message "Why the sky is blue?"
  $ ./ask_llm --model google/gemini2.5-pro --message "Why the sky is blue?"
  $ ./ask_llm --model openrouter/gemini2.5-pro --message "Why the sky is blue?"
  $ ./ask_llm --model openrouter/quasar-alpha --message "Why the sky is blue?"

```

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `ask_llm` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ask_llm, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/ask_llm>.

