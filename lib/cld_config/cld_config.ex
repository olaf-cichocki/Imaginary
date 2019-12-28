defmodule CldConfig do
  @moduledoc """
  Cloudinary config.
  """
  defstruct account: %CldAccount{}
  # url: %CldUrl{},
  # api: %CldApi{},
  # tag: %CldTag{}

  @type cldConfig() :: %__MODULE__{
          account: CldAccount.config()
          # url: %CldUrl{},
          # api: %CldApi{},
          # tag: %CldTag{}
        }
end
