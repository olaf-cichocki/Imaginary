defmodule AssetData do
  @moduledoc """
  A struct representing image asset.
  """

  defstruct [:id, :options, transformations: []]

  @type t() :: %__MODULE__{
          id: String.t(),
          transformations: list(String.t()),
          options: CldConfig.config()
        }
end
