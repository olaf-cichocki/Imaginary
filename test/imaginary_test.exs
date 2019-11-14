defmodule ImaginaryTest do
  use ExUnit.Case
  doctest Imaginary

  test "greets the world" do
    assert Imaginary.hello() == :world
  end
end
