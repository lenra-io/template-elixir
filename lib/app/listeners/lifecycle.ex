defmodule App.Listeners.Lifecycle do
  use Lenra.Listener

  alias App.Counters

  def_on_env_start %{api: api} do
    with {:ok, nil} <- Counters.get_global(api) do
      Counters.create_global(api)
    end
  end

  def_on_user_first_join %{api: api} do
    Counters.create_mine(api)
  end

  def_on_session_start _ do
    :ok
  end
end
