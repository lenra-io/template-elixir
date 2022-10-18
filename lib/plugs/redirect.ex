defmodule TemplateElixir.Plugs.Redirect do
  def init(default), do: default

  def call(%Plug.Conn{method: "POST"} = conn, _) do
    case conn.body_params do
      %{"action" => action} ->
        set_path_info(conn, ["listeners", action])

      %{"name" => name} ->
        set_path_info(conn, ["widgets", name])

      %{"resource" => resource} ->
        set_path_info(conn, ["resources", resource])

      _ ->
        set_path_info(conn, ["manifest"])
    end
  end

  def call(conn, _) do
    conn
  end

  defp set_path_info(conn, path_info) do
    conn
    |> Map.put(:request_path, Path.join(["/" | path_info]))
    |> Map.put(:path_info, path_info)
  end
end
