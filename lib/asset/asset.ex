defmodule Imaginary.Asset do
  @type size :: integer | float | String.t()
  @default_base_url "//res.cloudinary.com"

  @moduledoc """
  Url module helps manipulating creating urls to cloudinary assets, and can optionally transform the assets as well.

  Absolute minimum to create the url is calling `Imaginary.Asset`.to_url() with `AssetData` containing `cloud_name` and `id`.
  Check `CldConfig` documentation for a list of settings that can be set using env variables.

  ## Basic
  Use `Imaginary.Asset` function `base()` to create the necessary structure, and then `id()` to add asset id
      iex> alias Imaginary.Asset
      iex> Asset.base(%CldConfig{ account: %CldAccount{ cloud_name: "demo" }}) 
      ...> |> Asset.id("sample.jpg") 
      ...> |> Asset.to_url()
      "//res.cloudinary.com/demo/image/upload/sample.jpg"

  You can provide necesary struct directly if you really want
      iex> %AssetData{id: "sample.jpg", options: %CldConfig{ account: %CldAccount{ cloud_name: "demo" }}}
      ...> |> Imaginary.Asset.to_url()
      "//res.cloudinary.com/demo/image/upload/sample.jpg"

  ## Advanced Examples
      iex> alias Imaginary.Asset
      iex> Asset.base(%CldConfig{ account: %CldAccount{ cloud_name: "demo-cloud" }}) 
      ...> |> Asset.width(300) 
      ...> |> Asset.height(600) 
      ...> |> Asset.id("sample-image.jpg") 
      ...> |> Asset.to_url()
      "//res.cloudinary.com/demo-cloud/image/upload/w_300/h_600/sample-image.jpg"
  """

  @doc """
  Accepts options, creates necessary data structure. Some options cen be set using env variables.
  """
  @spec base(CldConfig.config()) :: AssetData.t()
  def base(options \\ %CldConfig{}) do
    %AssetData{options: options}
  end

  @doc """
  Add asset id.
  """
  @spec id(AssetData.t(), String.t()) :: AssetData.t()
  def id(image_data, id) do
    %AssetData{image_data | id: id}
  end

  @doc """
  Converts asset id and all the transformation to the resulting url
  """
  @spec to_url(AssetData.t()) :: String.t()
  def to_url(%AssetData{id: id, transformations: transformations, options: options} = _asset) do
    %CldConfig{account: account} = options

    transformation_string = transformations |> join_transformations

    [
      @default_base_url,
      account.cloud_name,
      "image/upload",
      transformation_string,
      id
    ]
    |> Enum.filter(fn value -> value !== "" end)
    |> Enum.join("/")
  end

  @doc """
  Set width of the image. [Official API Reference](https://cloudinary.com/documentation/image_transformation_reference#width_parameter){:target="_blank"}
  """
  @spec width(AssetData.t(), size) :: AssetData.t()
  def width(image_data, value) do
    "w_#{value}" |> update_transformations(image_data)
  end

  @doc """
  Set width of the image. [Official API Reference](https://cloudinary.com/documentation/image_transformation_reference#height_parameter){:target="_blank"}
  """
  @spec height(AssetData.t(), size) :: AssetData.t()
  def height(image_data, value) do
    "h_#{value}" |> update_transformations(image_data)
  end

  @spec update_transformations(String.t(), AssetData.t()) :: AssetData.t()
  defp update_transformations(new_transformation, image_data) do
    Map.update(image_data, :transformations, [], fn current_transformations ->
      [new_transformation | current_transformations]
    end)
  end

  defp join_transformations(transformations), do: Enum.reverse(transformations) |> Enum.join("/")
end
