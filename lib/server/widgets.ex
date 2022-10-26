defmodule Widgets do
  @moduledoc """
    The Entrypoint of the widgets.
    Responsible to call the specific widget that is matching the @name annotation.
  """
  use AnnotationModuleRegistry,
    annotation: :name,
    arity: 3

  alias Types.{Data, Props, Context}

  @spec call(Plug.Conn.t(), String.t(), Data.t(), Props.t(), Context.t()) :: Plug.Conn.t()
  def call(conn, name, data, props, context) do
    with {:ok, {mod, fun, data_struct, props_struct}} <-
           Utils.get_binding(get_bindings(), name, "widget #{name} not found."),
         transformed_data <- Utils.to_struct(data, data_struct),
         transformed_props <- Utils.to_struct(props, props_struct) do
      apply(mod, fun, [transformed_data, transformed_props, context])
    end
    |> Utils.send_resp_pipe(conn)
  end

  def new(name, opts \\ []) do
    %{type: "widget", name: name}
    |> Utils.add_all(opts, [:coll, :query, :props])
  end
end
