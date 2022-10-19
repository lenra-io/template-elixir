defmodule Listeners do
  use AnnotationModuleRegistry,
    annotation: :action,
    arity: 3

  def call_listener(action, props, event, api) do
    Utils.call_or_error(
      get_bindings(),
      action,
      [props, event, api],
      "Listener #{action} not found."
    )
  end
end
