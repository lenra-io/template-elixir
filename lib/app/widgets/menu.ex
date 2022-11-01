defmodule App.Widgets.Menu do
  use Widgets

  @name "menu"
  def menu_w(_data, _props, _context) do
    %{
      "child" => %{
        "children" => [
          %{
            "child" => %{"src" => "logo.png", "type" => "image"},
            "constraints" => %{
              "maxHeight" => 32,
              "maxWidth" => 32,
              "minHeight" => 32,
              "minWidth" => 32
            },
            "type" => "container"
          },
          %{
            "child" => %{
              "child" => %{
                "style" => %{"fontSize" => 24, "fontWeight" => "bold"},
                "textAlign" => "center",
                "type" => "text",
                "value" => "Hello World"
              },
              "type" => "container"
            },
            "type" => "flexible"
          }
        ],
        "crossAxisAlignment" => "center",
        "fillParent" => true,
        "mainAxisAlignment" => "spaceBetween",
        "padding" => %{"right" => 4},
        "type" => "flex"
      },
      "decoration" => %{
        "boxShadow" => %{
          "blurRadius" => 8,
          "color" => 0x1A000000,
          "offset" => %{"dx" => 0, "dy" => 1}
        },
        "color" => 0xFFFFFFFF
      },
      "padding" => %{"bottom" => 2, "left" => 4, "right" => 4, "top" => 2},
      "type" => "container"
    }
  end
end
