defmodule App.Props.Id do
  @enforce_keys [:_id]
  @derive Jason.Encoder
  defstruct _id: ""

  @type t :: %__MODULE__{
          _id: String.t()
        }
end
