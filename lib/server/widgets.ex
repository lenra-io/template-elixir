defmodule Widgets do
  use AnnotationModuleRegistry,
    annotation: :name,
    arity: 2

  def call_widget(name, data, props) do
    Utils.call_or_error(get_bindings(), name, [data, props], "widget #{name} not found.")
  end
end
