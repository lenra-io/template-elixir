defmodule TemplateElixir.Endpoint do
  @moduledoc """
  A Plug responsible for logging request info, parsing request body's as JSON,
  matching routes, and dispatching responses.
  """
  require Logger

  use Plug.Router

  # This module is a Plug, that also implements it's own plug pipeline, below:

  plug(Plug.Logger)
  plug(:match)
  plug(Plug.Parsers, parsers: [:json], json_decoder: Jason)
  plug(:dispatch)

  post "/" do
    case conn.body_params do
      %{"action" => action, "props" => props, "event" => event, "api" => api} ->
        Listeners.call_listener(action, props, event, api)

      %{"name" => name, "props" => props, "data" => data} ->
        Widgets.call_widget(name, data, props)

      _ ->
        raise "Invalid body params."
    end
    |> case do
      {:error, code, msg} ->
        send_resp(conn, code, msg)

      _res ->
        send_resp(conn, 200, "ok")
    end
  end

  match _ do
    send_resp(conn, 404, "oops... Nothing here :(")
  end
end
