defmodule App.Manifest do
  use Lenra.Manifest

  def lenra_routes() do
    [
      %{"path" => "/", "view" => App.Views.Main.r()},
      %{"path" => "/bar", "view" => App.Views.Bar.r()}
    ]
  end
end
