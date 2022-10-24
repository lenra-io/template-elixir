defmodule Listeners do
  use AnnotationModuleRegistry,
    arity: 3,
    annotation: :action

  def call(conn, action, props, event, api) do
    Utils.call_or_error(
      get_bindings(),
      action,
      [props, event, api],
      "Listener #{action} not found."
    )
    |> case do
      {:error, code, msg} ->
        Plug.Conn.send_resp(conn, code, msg)

      _res ->
        Plug.Conn.send_resp(conn, 200, "ok")
    end
  end

  def new(action, opts \\ []) do
    %{type: "listener", action: action}
    |> Utils.add_all(opts, [:props])
  end
end
