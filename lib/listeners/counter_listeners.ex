defmodule Listeners.CounterListeners do
  use Listeners

  @action "increment"
  def increment(props, event, api) do
    IO.inspect({@action, props, event, api})
    :ok
  end

  @action "decrement"
  def decrement(props, event, api) do
    IO.inspect({@action, props, event, api})
    :ok
  end
end
