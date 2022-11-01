defmodule App.Resources do
  @priv_dir :code.priv_dir(:template_elixir) |> List.to_string() |> Path.join("static")
  def call(conn, resource) do
    with {:ok, safe_path} <- Path.safe_relative_to(resource, @priv_dir),
         final_path <- Path.expand(Path.join(@priv_dir, safe_path)),
         true <- File.exists?(final_path) do
      Plug.Conn.send_file(conn, 200, final_path)
    else
      false -> Plug.Conn.send_resp(conn, 404, "File #{resource} not found")
      :error -> Plug.Conn.send_resp(conn, 404, "Unsafe path #{resource}")
    end
  end
end
