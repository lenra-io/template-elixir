defmodule App.Views.Home do
  use Lenra.View

  @moduledoc """
    The Home View
  """

  alias App.Counters
  alias App.Views

  defview _ do
    Flex.n(
      [
        Views.Counter.r(
          coll: Counters.coll(),
          query: Counters.get_mine_query(),
          props: %{text: "My personnal counter"}
        ),
        Views.Counter.r(
          coll: Counters.coll(),
          query: Counters.get_global_query(),
          props: %{text: "The common counter"}
        )
      ],
      spacing: 16,
      crossAxisAlignment: "center",
      mainAxisAlignment: "spaceEvenly",
      direction: Direction.vertical()
    )
  end
end
