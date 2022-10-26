defmodule Server.Endpoint do
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

  post _ do
    case conn.body_params do
      %{
        "action" => action,
        "props" => props,
        "event" => event,
        "api" => api
      } ->
        Logger.info("Calling listener #{action}")
        Listeners.call(conn, action, props, event, api)

      %{"widget" => name, "props" => props, "data" => data} ->
        Logger.info("Calling widget #{name}")
        Widgets.call(conn, name, data, props, %{})

      %{"resource" => resource} ->
        Logger.info("Calling resource #{resource}")
        App.Resources.call(conn, resource)

      _ ->
        Logger.info("Calling manifest")

        App.Manifest.call(conn)
    end
  end

  match _ do
    send_resp(conn, 404, "oops... Nothing here :(")
  end
end
