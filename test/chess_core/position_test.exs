defmodule ChessCore.PositionTest do
  @moduledoc """
  Tests for ChessCore.Position
  """

  use ExUnit.Case, async: true
  doctest ChessCore.Position

  test "default struct" do
    assert %ChessCore.Position{} == %ChessCore.Position{
             active_color: "",
             board: %{},
             castling: "",
             en_passant: "",
             halfmove: 0,
             move: 1
           }
  end

  test "parse initial FEN" do
    assert ChessCore.Position.parse_fen(
             "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1"
           ) == %ChessCore.Position{
             active_color: :w,
             board: %{
               {:a, 1} => :R,
               {:a, 2} => :P,
               {:a, 3} => nil,
               {:a, 4} => nil,
               {:a, 5} => nil,
               {:a, 6} => nil,
               {:a, 7} => :p,
               {:a, 8} => :r,
               {:b, 1} => :N,
               {:b, 2} => :P,
               {:b, 3} => nil,
               {:b, 4} => nil,
               {:b, 5} => nil,
               {:b, 6} => nil,
               {:b, 7} => :p,
               {:b, 8} => :n,
               {:c, 1} => :B,
               {:c, 2} => :P,
               {:c, 3} => nil,
               {:c, 4} => nil,
               {:c, 5} => nil,
               {:c, 6} => nil,
               {:c, 7} => :p,
               {:c, 8} => :b,
               {:d, 1} => :Q,
               {:d, 2} => :P,
               {:d, 3} => nil,
               {:d, 4} => nil,
               {:d, 5} => nil,
               {:d, 6} => nil,
               {:d, 7} => :p,
               {:d, 8} => :q,
               {:e, 1} => :K,
               {:e, 2} => :P,
               {:e, 3} => nil,
               {:e, 4} => nil,
               {:e, 5} => nil,
               {:e, 6} => nil,
               {:e, 7} => :p,
               {:e, 8} => :k,
               {:f, 1} => :B,
               {:f, 2} => :P,
               {:f, 3} => nil,
               {:f, 4} => nil,
               {:f, 5} => nil,
               {:f, 6} => nil,
               {:f, 7} => :p,
               {:f, 8} => :b,
               {:g, 1} => :N,
               {:g, 2} => :P,
               {:g, 3} => nil,
               {:g, 4} => nil,
               {:g, 5} => nil,
               {:g, 6} => nil,
               {:g, 7} => :p,
               {:g, 8} => :n,
               {:h, 1} => :R,
               {:h, 2} => :P,
               {:h, 3} => nil,
               {:h, 4} => nil,
               {:h, 5} => nil,
               {:h, 6} => nil,
               {:h, 7} => :p,
               {:h, 8} => :r
             },
             castling: "KQkq",
             en_passant: "-",
             halfmove: 0,
             move: 1
           }
  end
end
