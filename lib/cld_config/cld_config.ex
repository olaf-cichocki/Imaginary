defmodule CldConfig do
  @moduledoc """
  Cloudinary config.
  """
  defstruct account: %CldAccount{}
  # url: %CldUrl{},
  # api: %CldApi{},
  # tag: %CldTag{}

  @type t() :: %__MODULE__{
          account: CldAccount.t()
          # url: %CldUrl{},
          # api: %CldApi{},
          # tag: %CldTag{}
        }
end
