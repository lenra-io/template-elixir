defmodule TemplateElixirTest do
  use ExUnit.Case
  doctest TemplateElixir

  test "greets the world" do
    assert TemplateElixir.hello() == :world
  end
end
