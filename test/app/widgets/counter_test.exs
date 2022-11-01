defmodule App.Widgets.CounterTest do
  use ExUnit.Case
  alias App.Widgets

  test "foo" do
    assert %{
             "children" => [
               %{"value" => "foo : 42"},
               %{"onPressed" => %{"action" => "increment", "props" => %{"_id" => "1337"}}}
             ]
           } =
             Widgets.Counter.counter_w(
               [%App.Counters.Counter{_id: "1337", value: 42, user: "foo"}],
               %App.Props.Text{text: "foo"},
               %{}
             )
  end
end
