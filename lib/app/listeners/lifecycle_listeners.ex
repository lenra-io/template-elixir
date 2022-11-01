defmodule App.Listeners.LifecycleListeners do
  use Listeners

  @action "onEnvStart"
  def on_env_start(_props, _event, api) do
    with {:ok, nil} <- App.Counters.get_global(api) do
      App.Counters.create_global(api)
    end
  end

  @action "onUserFirstJoin"
  def on_user_first_join(_props, _event, api) do
    App.Counters.create_mine(api)
  end

  @action "onSessionStart"
  def on_session_start(_props, _event, _api) do
    :ok
  end
end
