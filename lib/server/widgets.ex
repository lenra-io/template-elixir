defmodule Widgets do
  @moduledoc """
    The Entrypoint of the widgets.
    Responsible to call the specific widget that is matching the @name annotation.
  """
  use AnnotationModuleRegistry,
    annotation: :name,
    arity: 3,
    data_struct?: true

  alias Types.{Data, Props, Context}

  @spec call(Plug.Conn.t(), String.t(), Data.t(), Props.t(), Context.t()) :: Plug.Conn.t()
  def call(conn, name, data, props, context) do
    with {:ok, {mod, fun, data_struct}} <-
           Utils.get_binding(get_bindings(), name, "widget #{name} not found."),
         transformed_data <- data_to_struct(data, data_struct) do
      apply(mod, fun, [transformed_data, props, context])
    end
    |> case do
      :error ->
        Plug.Conn.send_resp(conn, 500, "Unknown error")

      {:error, reason} when is_bitstring(reason) ->
        Plug.Conn.send_resp(conn, 500, reason)

      {:error, reason} when is_map(reason) or is_list(reason) ->
        Plug.Conn.send_resp(conn, 500, Jason.encode!(reason))

      {:error, status, reason} when is_bitstring(reason) ->
        Plug.Conn.send_resp(conn, status, reason)

      {:error, status, reason} when is_map(reason) or is_list(reason) ->
        Plug.Conn.send_resp(conn, status, Jason.encode!(reason))

      json ->
        Plug.Conn.send_resp(conn, 200, Jason.encode!(json))
    end
  end

  defp data_to_struct(data, nil), do: data

  defp data_to_struct(data, data_struct) do
    data
    |> Api.DataApi.with_atom()
    |> Api.DataApi.to_struct(data_struct)
  end

  def new(name, opts \\ []) do
    %{type: "widget", name: name}
    |> Utils.add_all(opts, [:coll, :query, :props])
  end
end
