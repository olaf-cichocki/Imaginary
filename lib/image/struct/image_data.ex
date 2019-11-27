defmodule ImageData do
  @moduledoc """
  A struct representing image asset.
  """

  # @enforce_keys [:id]
  # defstruct [:id, transformations: []]
  defstruct [:id, :base, :options, transformations: []]

  @type t() :: %__MODULE__{
          id: String.t(),
          base: String.t(),
          transformations: list(String),
          options: %CldConfig{}
        }
end
