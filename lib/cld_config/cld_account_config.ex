defmodule CldAccountConfig do
  @moduledoc """
  Account Cloudinary config.
  """
  defstruct [:cloud_name, :api_key, :api_secret, :auth_key, :auth_ip, :auth_acl]
end
