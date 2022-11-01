defmodule App.Widgets.Home do
  use Widgets

  alias App.Widgets

  @name "home"
  def home_w(_data, _props, _context) do
    %{
      "children" => [
        Widgets.Counter.new_counter(
          coll: App.Counters.coll(),
          query: App.Counters.get_mine_query(),
          props: %{"text" => "My personnal counter"}
        ),
        Widgets.Counter.new_counter(
          coll: App.Counters.coll(),
          query: App.Counters.get_global_query(),
          props: %{"text" => "The common counter"}
        )
      ],
      "crossAxisAlignment" => "center",
      "direction" => "vertical",
      "mainAxisAlignment" => "spaceEvenly",
      "spacing" => 32,
      "type" => "flex"
    }
  end
end
