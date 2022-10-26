defmodule App.Widgets.Main do
  use Widgets

  alias App.Widgets

  @name "main"
  def main(_data, _props, _context) do
    %{
      "children" => [
        Widgets.Menu.new_menu(),
        Widgets.Home.new_home()
      ],
      "crossAxisAlignment" => "center",
      "direction" => "vertical",
      "scroll" => true,
      "spacing" => 32,
      "type" => "flex"
    }
  end
end
