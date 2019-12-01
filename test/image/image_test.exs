defmodule Imaginary.ImageTest do
  use ExUnit.Case
  alias Imaginary.Image, as: Image
  doctest Imaginary.Image

  @config %CldConfig{
    account: %CldAccount{cloud_name: "demo"}
  }
  @image_struct %ImageData{id: "sample.jpg", transformations: [], options: @config}

  test "id() creates corect struct" do
    assert Image.id("sample.jpg", @config) === @image_struct

    assert Image.id("sample.jpg") === %ImageData{
             id: "sample.jpg",
             transformations: [],
             options: %CldConfig{}
           }
  end

  test "to_url() creates url" do
    assert @image_struct |> Image.to_url() ===
             "https://res.cloudinary.com/demo/image/upload/sample.jpg"
  end
end
