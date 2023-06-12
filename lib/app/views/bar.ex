defmodule App.Views.Bar do
  use Lenra.View

  defview _ do
    %{
      "type" => "text",
      "value" => "Hello from App.Views.Bar",
    }
  end
end
