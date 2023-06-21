defmodule App.Views.Counter do
  use Lenra.View

  @moduledoc """
    The Counter View
  """

  alias App.Listeners.Counter

  defview %{data: [%{"value" => value, "_id" => id}], props: %{"text" => text}} do
    Flex.n(
      [
        Text.n("#{text} : #{value}"),
        Button.n("+", onPressed: Counter.increment_r(props: %{_id: id}))
      ],
      spacing: 16,
      mainAxisAlignment: "spaceEvenly",
      crossAxisAlignment: "center"
    )
  end
end
