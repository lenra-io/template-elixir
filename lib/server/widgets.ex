defmodule Widgets do
  use AnnotationModuleRegistry,
    annotation: :name,
    arity: 3

  # @callback call(map(), map()) :: map()

  def call(conn, name, data, props, context) do
    Utils.call_or_error(get_bindings(), name, [data, props, context], "widget #{name} not found.")
    |> case do
      {:error, code, msg} ->
        Plug.Conn.send_resp(conn, code, msg)

      res ->
        case Jason.encode(res) do
          {:ok, str} ->
            Plug.Conn.send_resp(conn, 200, str)

          {:error, _} ->
            Plug.Conn.send_resp(conn, 500, "Not a valid JSON : #{inspect(res)} ")
        end
    end
  end

  def new(name, opts \\ []) do
    %{type: "widget", name: name}
    |> Utils.add_all(opts, [:coll, :query, :props])
  end
end
