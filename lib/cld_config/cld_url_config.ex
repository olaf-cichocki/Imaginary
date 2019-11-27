defmodule CldUrlConfig do
  @moduledoc """

  """
  defstruct [
    :cdn_subdomain,
    :secure_cdn_subdomain,
    :cname,
    :secure,
    :secure_distribution,
    :private_cdn,
    :sign_url,
    :shorten,
    :use_root_path,
    :exclude_version
  ]
end
