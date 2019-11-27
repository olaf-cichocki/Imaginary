defmodule Imaginary.Image do
  @moduledoc """
  Image module helps manipulating the images.

  ## Examples

      iex> Imaginary.Image.id("sample.jpg") |> Imaginary.Image.to_url()
      "https://res.cloudinary.com/demo/image/upload/sample.jpg"
  """

  @doc """
  Prepares whole process by creating map with asset id

  ## Examples

  iex> Imaginary.Image.id('sample-image.jpg')
  %ImageData{id: 'sample-image.jpg'}


  """
  @spec id(String.t(), options?: %CldConfig{}) :: %ImageData{id: String.t()}
  def id(id, options \\ nil) do
    %ImageData{id: id, options: options}
  end

  @doc """
  Converts asset id and all the transformation to the resulting url
  """
  @spec to_url(%ImageData{}) :: String.t()
  def to_url(%{id: id, options: options} = _asset) do
    # %{account: account} = options

    "https://res.cloudinary.com/" <>
      "demo" <> "/image/upload/" <> id
  end
end
