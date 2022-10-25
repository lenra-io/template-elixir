defmodule App.Listeners.CounterListeners do
  use Listeners

  @action "increment"
  def increment(props, _event, api) do
    id = Map.get(props, "_id")
    App.Counters.increment(api, id)
  end
end
