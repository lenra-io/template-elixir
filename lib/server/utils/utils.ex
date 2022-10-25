defmodule Utils do
  def fn_to_string(mod, fun) do
    arity = mod.__info__(:functions) |> Keyword.get(fun)
    "#{inspect(mod)}.#{fun}/#{arity}"
  end

  def call_or_error(bindings, key, args, error_404) do
    if Map.has_key?(bindings, key) do
      {mod, fun} = Map.get(bindings, key)
      apply(mod, fun, args)
    else
      {:error, 404, error_404}
    end
  end

  def get_binding(bindings, key, error_404) do
    if Map.has_key?(bindings, key) do
      {:ok, Map.get(bindings, key)}
    else
      {:error, 404, error_404}
    end
  end

  def add_all(map, opts, keys) do
    keys
    |> Enum.reduce(%{}, fn k, new_map ->
      case Keyword.get(opts, k) do
        nil -> new_map
        v -> Map.put(new_map, k, v)
      end
    end)
    |> Map.merge(map)
  end
end
