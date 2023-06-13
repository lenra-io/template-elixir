defmodule App.Manifest do
  use Lenra.Manifest

  @moduledoc """
    The Manifest, where all the views are defined
  """

  alias App.Views.{Bar, Main}

  # def lenra_routes do
  #   [
  #     %{"path" => "/", "view" => Main.r()},
  #     %{"path" => "/bar", "view" => Bar.r()}
  #   ]
  # end

  def root_view do
    Main.name()
  end
end
