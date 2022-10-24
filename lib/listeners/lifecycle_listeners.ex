defmodule Listeners.LifecycleListeners do
  use Listeners

  @action "onEnvStart"
  def on_env_starts(_props, _event, _api) do
    IO.inspect(@action)
    :ok
  end

  @action "onUserFirstJoin"
  def on_user_first_join(_props, _event, _api) do
    IO.inspect(@action)
    :ok
  end

  @action "onSessionStart"
  def on_session_start(_props, _event, _api) do
    IO.inspect(@action)
    :ok
  end
end
