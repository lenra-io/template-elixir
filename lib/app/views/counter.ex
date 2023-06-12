defmodule App.Views.Counter do
  use Lenra.View

  @moduledoc """
    The Counter View
  """

  alias App.Listeners.Counter

  defview %{data: [counter], props: props} do
    %{
      "children" => [
        %{"type" => "text", "value" => "#{props["text"]} : #{counter["value"]}"},
        %{
          "onPressed" => Counter.increment_r(props: %{_id: counter["_id"]}),
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
