defmodule CldAccount do
  @moduledoc """
  Cloudinary config for account.
  """
  # @enforce_keys [:cloud_name]
  # TODO: Investigate enforce_keys
  defstruct cloud_name: System.get_env("CLD_CLOUD_NAME"),
            api_key: System.get_env("CLD_API_KEY"),
            api_secret: System.get_env("CLD_API_SECRET")

  # unused:
  # :auth_key,
  # :auth_ip,
  # :auth_acl

  @typedoc """
  Basic account configuration.

  It contains keys as folows:
  * `:cloud_name`: To use the Imaginary library, you have to configure at least your cloud_name. You can set it globally using `CLD_CLOUD_NAME` env variable

  ### WIP:
  * `:api_key`: needed for secure API calls to Cloudinary (e.g., image and video uploads).
  * `:api_secret`: needed for secure API calls to Cloudinary (e.g., image and video uploads).
  """
  @type config() :: %__MODULE__{
          cloud_name: String.t() | nil,
          api_key: String.t() | nil,
          api_secret: String.t() | nil
        }
end
