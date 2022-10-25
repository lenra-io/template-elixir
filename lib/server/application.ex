defmodule Server.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  require Logger

  @port 3000
  @impl true
  def start(_type, _args) do
    Logger.info("Initializing Listeners...")
    Listeners.init()
    Logger.info("Initializing Widgets...")
    Widgets.init()

    children = [
      {Plug.Cowboy, scheme: :http, plug: Server.Endpoint, port: @port},
      {Finch,
       name: HttpClient,
       pools: %{
         :default => [size: 10]
       }}
    ]

    opts = [strategy: :one_for_one, name: TemplateElixir.Supervisor]
    res = Supervisor.start_link(children, opts)
    Logger.info("Application is started on port #{@port}")
    res
  end
end
