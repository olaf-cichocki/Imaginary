defmodule ImageData do
  @moduledoc """
  A struct representing image asset.
  """

  # @enforce_keys [:id]
  # defstruct [:id, transformations: []]
  defstruct [:id, :options, transformations: []]

  @type asset() :: %__MODULE__{
          id: String.t(),
          transformations: list(String),
          options: %CldConfig{}
        }
end
