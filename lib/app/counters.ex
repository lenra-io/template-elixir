defmodule App.Counters do
  alias App.Counters.Counter

  @coll "counters"

  def coll do
    @coll
  end

  def get_global(api) do
    case Api.DataApi.execute_query(api, @coll, get_global_query(), as: Counter) do
      {:ok, [res]} -> {:ok, res}
      {:ok, []} -> {:ok, nil}
      err -> err
    end
  end

  defp create(api, who) do
    Api.DataApi.create_doc(api, @coll, %Counter{value: 0, user: who})
  end

  def create_mine(api) do
    create(api, "@me")
  end

  def create_global(api) do
    create(api, "global")
  end

  def get_mine_query() do
    %{
      user: "@me"
    }
  end

  def get_global_query() do
    %{
      user: "global"
    }
  end

  def increment(api, id) do
    with {:ok, counter} <- Api.DataApi.get_doc(api, @coll, id, as: App.Counters.Counter) do
      new_ct = Map.put(counter, :value, counter.value + 1)
      Api.DataApi.update_doc(api, @coll, new_ct)
    end
  end
end
