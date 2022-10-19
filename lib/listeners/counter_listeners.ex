defmodule Listeners.CounterListeners do
  use Listeners

  @action "increment"
  def increment(props, event, api) do
    IO.inspect({props, event, api})
    :ok
  end
end
