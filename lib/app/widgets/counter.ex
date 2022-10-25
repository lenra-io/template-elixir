defmodule App.Widgets.Counter do
  use Widgets

  alias App.Listeners.CounterListeners

  @name "counter"
  @data_struct App.Counters.Counter
  def counter_w(data, props, _context) do
    counter = List.first(data)

    text = "#{Map.get(props, "text")} : #{counter.value}"

    %{
      "children" => [
        %{"type" => "text", "value" => text},
        %{
          "onPressed" => CounterListeners.new_increment(props: %{"_id" => counter._id}),
          "text" => "+",
          "type" => "button"
        }
      ],
      "crossAxisAlignment" => "center",
      "mainAxisAlignment" => "spaceEvenly",
      "spacing" => 2,
      "type" => "flex"
    }
  end
end
