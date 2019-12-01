defmodule CldAccount do
  @moduledoc """
  Cloudinary config for account.
  """
  defstruct [
    :cloud_name
    # unused:
    # :api_key,
    # :api_secret,
    # :auth_key,
    # :auth_ip,
    # :auth_acl
  ]

  @type config() :: %__MODULE__{
          cloud_name: String.t()
        }
end
