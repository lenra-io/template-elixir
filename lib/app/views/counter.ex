defmodule App.Views.Counter do
  use Lenra.View

  alias App.Listeners
  alias App.Props.Id

  defview %{data: [counter], props: props} do
    %{
      "children" => [
        %{"type" => "text", "value" => "#{props["text"]} : #{counter["value"]}"},
        %{
          "onPressed" => Listeners.Counter.increment_r(props: %{_id: counter["_id"]}),
          "text" => "+",
          "type" => "button"
        }
      ],
      "crossAxisAlignment" => "center",
      "mainAxisAlignment" => "spaceEvenly",
      "spacing" => 16,
      "type" => "flex"
    }
  end
end
