defmodule TemplateElixir.Endpoint do
  @moduledoc """
  A Plug responsible for logging request info, parsing request body's as JSON,
  matching routes, and dispatching responses.
  """

  use Plug.Router

  # This module is a Plug, that also implements it's own plug pipeline, below:

  plug(Plug.Logger)
  plug(:match)
  plug(Plug.Parsers, parsers: [:json], json_decoder: Jason)
  plug(:dispatch)

  post "/" do
    # Check conn.body_params to redirect to listeners/widget/manifest/resources
    case conn.body_params do
      %{"action" => _} ->
        Listeners.run(conn, conn.body_params)

      _ ->
        raise "Invalid body params."
    end

    send_resp(conn, 200, "ok")
  end

  match _ do
    send_resp(conn, 404, "oops... Nothing here :(")
  end
end
