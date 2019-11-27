defmodule CldConfig do
  @moduledoc """
  Global Cloudinary config.
  """
  defstruct [:account, :url, :api, :tag]
  @type t() :: %__MODULE__{account: %CldAccountConfig{}, url: %CldUrlConfig{}}
end
