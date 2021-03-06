defmodule Imaginary.Asset do
  @type size :: integer | float | String.t()
  @default_base_url "//res.cloudinary.com"
  @default_config %CldConfig{}

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
      {:ok, "//res.cloudinary.com/demo/image/upload/sample.jpg"}

  You can provide necesary struct directly if you really want
      iex> %AssetData{id: "sample.jpg", options: %CldConfig{ account: %CldAccount{ cloud_name: "demo" }}}
      ...> |> Imaginary.Asset.to_url()
      {:ok, "//res.cloudinary.com/demo/image/upload/sample.jpg"}

  ## Advanced Examples
      iex> alias Imaginary.Asset
      iex> Asset.base(%CldConfig{ account: %CldAccount{ cloud_name: "demo-cloud" }}) 
      ...> |> Asset.width(300) 
      ...> |> Asset.height(600) 
      ...> |> Asset.id("sample-image.jpg") 
      ...> |> Asset.to_url()
      {:ok, "//res.cloudinary.com/demo-cloud/image/upload/w_300/h_600/sample-image.jpg"}
  """

  ######################
  ### BASIC CREATION ###
  ######################

  @doc """
  Creates necessary data structure. Uses only options set using env variables.
  """
  @spec base() :: AssetData.t()
  def base() do
    %AssetData{options: @default_config}
  end

  @doc """
  Accepts options, creates necessary data structure. Some options cen be set using env variables.
  """
  @spec base(CldConfig.t()) :: AssetData.t()
  def base(options) do
    # TODO: Merge options
    %AssetData{options: options}
  end

  ######################
  ## TRANSFORMATIONS ##
  ######################

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

  @doc """
  Add asset id.
  """
  @spec id(AssetData.t(), String.t()) :: AssetData.t()
  def id(image_data, id) do
    %AssetData{image_data | id: id}
  end

  ######################
  #### URL BUILDING ####
  ######################

  @doc """
  Converts asset id and all the transformation to the resulting url
  """
  @spec to_url(AssetData.t()) :: {:ok, String.t()}
  def to_url(%AssetData{id: id, transformations: transformations, options: options} = _asset) do
    %CldConfig{account: account} = options

    transformation_string = transformations |> join_transformations

    build_url(
      account.cloud_name,
      transformation_string,
      id
    )
  end

  @spec join_transformations(list(String.t())) :: String.t()
  defp join_transformations(transformations), do: Enum.reverse(transformations) |> Enum.join("/")

  defp build_url(_cloud_name, _transformations, id) when is_nil(id), do: {:error, "Missing :id"}

  defp build_url(cloud_name, _transformations, _id) when is_nil(cloud_name),
    do: {:error, "Missing :cloud_name"}

  defp build_url(cloud_name, transformations, id) do
    url =
      [
        @default_base_url,
        cloud_name,
        "image/upload",
        transformations,
        id
      ]
      |> Enum.filter(fn value -> value !== "" end)
      |> Enum.join("/")

    {:ok, url}
  end
end
