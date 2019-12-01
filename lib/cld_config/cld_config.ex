defmodule CldConfig do
  @moduledoc """
  Global Cloudinary config.
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
