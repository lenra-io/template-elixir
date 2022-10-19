defmodule TemplateElixir.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  require Logger

  @port 3000
  @impl true
  def start(_type, _args) do
    Listeners.init()
    Widgets.init()

    children = [
      {Plug.Cowboy, scheme: :http, plug: TemplateElixir.Endpoint, port: @port}
    ]

    opts = [strategy: :one_for_one, name: TemplateElixir.Supervisor]
    res = Supervisor.start_link(children, opts)
    Logger.info("Application is started on port #{@port}")
    res
  end
end
