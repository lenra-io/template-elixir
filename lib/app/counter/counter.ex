defmodule App.Counters.Counter do
  @derive Jason.Encoder
  @enforce_keys [:value, :user]
  defstruct value: 0,
            user: "",
            _id: nil

  @type t :: %__MODULE__{
          value: integer(),
          user: String.t(),
          _id: String.t() | nil
        }
end
