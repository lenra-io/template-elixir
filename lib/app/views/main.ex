defmodule App.Views.Main do
  use Lenra.View
  # use Lenra.Components

  @moduledoc """
    The Main View
  """

  alias App.Views.{Home, Menu}

  defview _ do
    Flex.n(
      [
        Menu.r(),
        Home.r()
      ],
      crossAxisAlignment: Alignment.center(),
      direction: Direction.vertical(),
      scroll: true,
      spacing: 4
    )
  end
end
