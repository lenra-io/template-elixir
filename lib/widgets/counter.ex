defmodule Widgets.Counter do
  use Widgets

  @name "counter"
  def counter(_data, _props, _context) do
    %{}
  end

  @name "main"
  def main(_data, _props, _context) do
    %{"type" => "image", "src" => "logo.png"}
  end
end
