defmodule AnnotationModuleRegistry do
  defmacro __using__(opts) do
    annotation_name = Keyword.fetch!(opts, :annotation)
    needed_arity = Keyword.fetch!(opts, :arity)

    quote do
      defmacro __using__(_opts) do
        quote do
          # @behaviour unquote(__MODULE__)

          use UsesTracker, unquote(__MODULE__)
          @bindings %{}
          @on_definition {unquote(__MODULE__), :__on_definition__}
          @before_compile {unquote(__MODULE__), :__before_compile__}
        end
      end

      defmacro __before_compile__(env) do
        parent_module = __MODULE__

        b1 =
          quote do
            def bindings do
              @bindings
            end
          end

        rest =
          Module.get_attribute(env.module, :bindings)
          |> Enum.map(fn {k, v} ->
            f_name = String.to_atom("new_" <> k)

            quote do
              def unquote(f_name)(opts \\ []) do
                unquote(parent_module).new(unquote(k), opts)
                |> Api.DataApi.to_map()
              end
            end
          end)

        [b1 | rest]
      end

      def __on_definition__(env, _kind, name, args, _guards, _body) do
        an = unquote(annotation_name)
        arity = unquote(needed_arity)

        attr = Module.delete_attribute(env.module, an)
        data_struct = Module.delete_attribute(env.module, :data_struct)
        props_struct = Module.delete_attribute(env.module, :props_struct)

        current_bindings = Module.get_attribute(env.module, :bindings)

        with attr when not is_nil(attr) <- attr,
             :ok <- check_arity(args, arity, env.module, name),
             :ok <- check_exists(current_bindings, attr, an, arity) do
          current_bindings =
            Map.put(current_bindings, attr, {env.module, name, data_struct, props_struct})

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
          :application.get_key(:template_elixir, :modules)
          |> elem(1)
          |> Enum.filter(fn module ->
            not is_nil(module.module_info(:functions)[:__lenra_uses]) and
              __MODULE__ in module.__lenra_uses()
          end)
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
