defmodule App.Views.Home do
  use Lenra.View

  alias App.Views
  alias App.Counters

  defview _ do
    %{
      "children" => [
        Views.Counter.r(
          coll: Counters.coll(),
          query: Counters.get_mine_query(),
          props: %{"text" => "My personnal counter"}
        ),
        Views.Counter.r(
          coll: Counters.coll(),
          query: Counters.get_global_query(),
          props: %{"text" => "The common counter"}
        ),
        %{
          "type" => "button",
          "text" => "Go to bar",
          "onPressed" => %{
            "action" => "@lenra:navTo",
            "props" => %{"path" => "/bar"}
          }
        }
      ],
      "crossAxisAlignment" => "center",
      "direction" => "vertical",
      "mainAxisAlignment" => "spaceEvenly",
      "spacing" => 32,
      "type" => "flex"
    }
  end
end
