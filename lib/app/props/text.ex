defmodule App.Props.Text do
  @enforce_keys [:text]
  @derive Jason.Encoder
  defstruct text: ""

  @type t :: %__MODULE__{
          text: String.t()
        }
end
