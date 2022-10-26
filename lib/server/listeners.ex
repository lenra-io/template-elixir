defmodule Listeners do
  use AnnotationModuleRegistry,
    arity: 3,
    annotation: :action

  alias Types.{Props, Event, Api}

  @spec call(Plug.Conn.t(), String.t(), Props.t(), Event.t(), Api.t()) :: Plug.Conn.t()
  def call(conn, action, props, event, api) do
    with {:ok, {mod, fun, _data_struct, props_struct}} <-
           Utils.get_binding(get_bindings(), action, "Listener #{action} not found."),
         transformed_props <- Utils.to_struct(props, props_struct) do
      apply(mod, fun, [transformed_props, event, api])
    end
    |> Utils.send_resp_pipe(conn)
  end

  def new(action, opts \\ []) do
    %{action: action}
    |> Utils.add_all(opts, [:props])
  end
end
