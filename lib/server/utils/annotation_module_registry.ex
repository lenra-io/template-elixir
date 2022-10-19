defmodule AnnotationModuleRegistry do
  defmacro __using__(opts) do
    annotation_name = Keyword.fetch!(opts, :annotation)
    needed_arity = Keyword.fetch!(opts, :arity)

    quote do
      defmacro __using__(_opts) do
        quote do
          use UsesTracker, unquote(__MODULE__)
          @bindings %{}
          @on_definition {unquote(__MODULE__), :__on_definition__}
          @before_compile {unquote(__MODULE__), :__before_compile__}
        end
      end

      defmacro __before_compile__(_env) do
        quote do
          def bindings do
            @bindings
          end

          def call(binding) do
            {module, name} = Map.get(@bindings, binding)
            apply(module, name, [])
          end
        end
      end

      def __on_definition__(env, _kind, name, args, _guards, _body) do
        an = unquote(annotation_name)
        arity = unquote(needed_arity)
        attr = Module.get_attribute(env.module, an)
        Module.delete_attribute(env.module, an)
        current_bindings = Module.get_attribute(env.module, :bindings)

        with attr when not is_nil(attr) <- attr,
             :ok <- check_arity(args, arity, env.module, name),
             :ok <- check_exists(current_bindings, attr, an, arity) do
          current_bindings = Map.put(current_bindings, attr, {env.module, name})

          Module.put_attribute(env.module, :bindings, current_bindings)
        else
          {:error, reason} -> IO.warn(reason, Macro.Env.stacktrace(env))
          e -> :ok
        end
      end

      def check_exists(current_bindings, attr, an, arity) do
        case Map.has_key?(current_bindings, attr) do
          false ->
            :ok

          true ->
            {module, fun} = Map.get(current_bindings, attr)
            displayable_fun_name = "#{inspect(module)}.#{fun}/#{arity}"

            {:error,
             "The #{an} \"#{attr}\" is already binded to the function #{displayable_fun_name}"}
        end
      end

      defp check_arity(args, arity, module, fun) do
        fun_arity = Enum.count(args)

        if fun_arity == arity do
          :ok
        else
          error_fun = "#{inspect(module)}.#{fun}/#{fun_arity}"
          correct_fun = "#{inspect(module)}.#{fun}/#{arity}"
          {:error, "The function arity #{error_fun} is invalid. Should be #{correct_fun}."}
        end
      end

      def init() do
        load_bindings()
      end

      defp load_bindings() do
        res =
          :code.all_loaded()
          |> Enum.filter(fn {module, _} ->
            not is_nil(module.module_info(:functions)[:__lenra_uses]) and
              __MODULE__ in module.__lenra_uses()
          end)
          |> Enum.map(&elem(&1, 0))
          |> Enum.reduce(%{}, fn mod, merged_bindings ->
            module_bindings = apply(mod, :bindings, [])

            Map.merge(merged_bindings, module_bindings)
          end)

        :persistent_term.put(__MODULE__, res)
      end

      def get_bindings() do
        :persistent_term.get(__MODULE__)
      end
    end
  end
end
