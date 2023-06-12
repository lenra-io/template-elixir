defmodule App.Views.Bar do
  use Lenra.View

  @moduledoc """
    The Bar View
  """

  defview _ do
    %{
      "type" => "text",
      "value" => "Hello from App.Views.Bar"
    }
  end
end
