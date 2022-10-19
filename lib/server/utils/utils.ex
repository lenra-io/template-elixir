defmodule Utils do
  def fn_to_string(mod, fun) do
    arity = mod.__info__(:functions) |> Keyword.get(fun)
    "#{inspect(mod)}.#{fun}/#{arity}"
  end

  def call_or_error(registry, key, args, error_404) do
    if Map.has_key?(registry, key) do
      {mod, fun} = Map.get(registry, key)
      apply(mod, fun, args)
    else
      {:error, 404, error_404}
    end
  end
end
