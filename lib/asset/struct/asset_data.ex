defmodule AssetData do
  @moduledoc """
  A struct representing image asset.
  """

  defstruct [:id, :options, transformations: []]

  @type t() :: %__MODULE__{
          id: String.t() | nil,
          transformations: list(String.t()),
          options: CldConfig.t()
        }
end
