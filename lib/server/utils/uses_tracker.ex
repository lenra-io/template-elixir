defmodule UsesTracker do
  defmodule Registry do
    defmacro __before_compile__(_) do
      quote location: :keep do
        def __lenra_uses do
          @lenra_uses
        end
      end
    end
  end

  defmacro __using__(module) do
    quote location: :keep do
      @before_compile Registry
      Module.register_attribute(__MODULE__, :lenra_uses, accumulate: true)
      Module.put_attribute(__MODULE__, :lenra_uses, unquote(module))
    end
  end
end
