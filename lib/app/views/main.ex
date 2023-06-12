defmodule App.Views.Main do
  use Lenra.View

  alias App.Views.{Home, Menu}

  defview _ do
    %{
      "children" => [
        Menu.r(),
        Home.r()
      ],
      "crossAxisAlignment" => "center",
      "direction" => "vertical",
      "scroll" => true,
      "spacing" => 32,
      "type" => "flex"
    }
  end
end
