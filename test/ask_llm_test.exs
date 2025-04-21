defmodule AskLlmTest do
  use ExUnit.Case
  doctest AskLlm

  test "greets the world" do
    assert AskLlm.hello() == :world
  end
end
