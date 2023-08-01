defmodule App.Application do
  use Application

  @moduledoc """
    The Base application containing the app entrypoint.
  """

  def start(_type, _args) do
    children = [
      App
    ]

    opts = [strategy: :one_for_one]
    Supervisor.start_link(children, opts)
  end
end
