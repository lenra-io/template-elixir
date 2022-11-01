defmodule App.Listeners.CounterListeners do
  use Listeners
  alias App.Props.Id

  @action "increment"
  @props_struct Id
  def increment(%Id{} = props, _event, api) do
    App.Counters.increment(api, props._id)
  end
end
