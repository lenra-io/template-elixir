defmodule App.Widgets.Counter do
  use Widgets

  alias App.Listeners.CounterListeners
  alias App.Counters.Counter
  alias App.Props.{Text, Id}

  @name "counter"
  @data_struct Counter
  @props_struct Text
  def counter_w([%Counter{} = counter], %Text{} = props, _context) do
    %{
      "children" => [
        %{"type" => "text", "value" => "#{props.text} : #{counter.value}"},
        %{
          "onPressed" => CounterListeners.new_increment(props: %Id{_id: counter._id}),
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
