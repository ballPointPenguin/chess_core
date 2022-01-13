defmodule ChessCoreTest do
  use ExUnit.Case
  doctest ChessCore

  test "greets the world" do
    assert ChessCore.hello() == :world
  end
end
