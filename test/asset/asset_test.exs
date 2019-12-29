defmodule Imaginary.AssetTest do
  use ExUnit.Case
  alias Imaginary.Asset, as: Asset
  doctest Imaginary.Asset

  @image_struct %AssetData{transformations: [], options: %CldConfig{}}
  @id "sample.jpg"
  @config %CldConfig{
    account: %CldAccount{cloud_name: "demo"}
  }
  @final_image_struct %AssetData{id: @id, options: @config, transformations: []}

  test("base() creates correct struct") do
    assert Asset.base(@config) === %AssetData{options: @config, transformations: []}

    assert Asset.base() === %AssetData{
             transformations: [],
             options: %CldConfig{}
           }
  end

  test "id() adds id to struct" do
    assert @image_struct |> Asset.id("sample.jpg") === %AssetData{
             id: "sample.jpg",
             transformations: [],
             options: %CldConfig{}
           }
  end

  test "with() sets width" do
    assert @final_image_struct |> Asset.width(350) |> Asset.to_url() ===
             {:ok, "//res.cloudinary.com/demo/image/upload/w_350/sample.jpg"}
  end

  test "height() sets width" do
    assert @final_image_struct |> Asset.height(750) |> Asset.to_url() ===
             {:ok, "//res.cloudinary.com/demo/image/upload/h_750/sample.jpg"}
  end

  test "to_url() creates url" do
    assert @final_image_struct |> Asset.to_url() ===
             {:ok, "//res.cloudinary.com/demo/image/upload/sample.jpg"}
  end
end
