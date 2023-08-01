defmodule App.Views.Menu do
  use Lenra.View

  @moduledoc """
    The Menu View
  """
  alias App.Views.Menu.Layout
  alias App.Views.Menu.HelloWorld
  alias App.Views.Menu.Logo

  defview _ do
    Layout.n(%{children: [Logo.n(), HelloWorld.n()]})
  end

  # We can split our code using function or submodules
  # I've used module here but you can use function too.
  defmodule Logo do
    use Lenra.View

    defview _ do
      Container.n(
        constraints: BoxConstraints.n(maxHeight: 32, maxWidth: 32, minHeight: 32, minWidth: 32),
        child: Image.n("logo.png")
      )
    end
  end

  defmodule HelloWorld do
    use Lenra.View

    defview _ do
      Flexible.n(
        Container.n(
          child:
            Text.n("Hello World",
              textAlign: "center",
              style: TextStyle.n(fontSize: 42, fontWeight: "bold")
            )
        )
      )
    end
  end

  defmodule Layout do
    use Lenra.View

    defview %{children: children} do
      Container.n(
        child:
          Flex.n(children,
            padding: Padding.n(right: 32),
            mainAxisAlignment: "spaceBetween",
            crossAxisAlignment: "center",
            fillParent: true
          ),
        padding: Padding.n(bottom: 16, top: 16, left: 32, right: 32),
        decoration:
          BoxDecoration.n(
            color: 0xFFFFFFFF,
            boxShadow:
              BoxShadow.n(
                blurRadius: 8,
                color: 0x1A000000,
                offset: Offset.n(dx: 0, dy: 1)
              )
          )
      )
    end
  end
end
