defmodule App.Manifest do
  use Lenra.Manifest

  @moduledoc """
    The Manifest, where all the views are defined
  """

  alias App.Views.{Main}

  def lenra_routes do
    [
      %{"path" => "/", "view" => Main.r()}
    ]
  end

  def root_view do
    Main.name()
  end
end
