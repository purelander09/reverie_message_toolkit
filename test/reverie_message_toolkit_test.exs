defmodule ReverieMessageToolkitTest do
  use ExUnit.Case
  doctest ReverieMessageToolkit

  test "greets the world" do
    assert ReverieMessageToolkit.hello() == :world
  end
end
