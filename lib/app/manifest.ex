defmodule App.Manifest do
  @spec call(Plug.Conn.t()) :: Plug.Conn.t()
  def call(conn) do
    res = %{"manifest" => manifest()}
    Plug.Conn.send_resp(conn, 200, Jason.encode!(res))
  end

  defp manifest() do
    %{
      "rootWidget" => "main",
      "lenraRoutes" => lenra(),
      "jsonRoutes" => json()
    }
  end

  defp lenra() do
    %{}
  end

  defp json() do
    %{}
  end
end
