defmodule App.Resources do
  @priv_dir "priv/static"
  def call(conn, resource) do
    with {:ok, safe_path} <- Path.safe_relative_to(resource, @priv_dir),
         final_path <- Path.expand(Path.join(@priv_dir, safe_path)),
         true <- File.exists?(final_path) do
      Plug.Conn.send_file(conn, 200, final_path)
    else
      _e -> Plug.Conn.send_resp(conn, 404, "File #{resource} not found")
    end
  end
end
