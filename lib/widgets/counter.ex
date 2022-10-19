defmodule Widgets.Counter do
  use Widgets

  @name "counter"
  def counter(data, props) do
    IO.inspect({data, props})
  end
end
