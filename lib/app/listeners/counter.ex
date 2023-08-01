defmodule App.Listeners.Counter do
  use Lenra.Listener

  @moduledoc """
    The Counter Listeners
  """

  alias App.Counters

  deflistener :increment, %{api: api, props: %{"_id" => id}} do
    Counters.increment(api, id)
  end
end
