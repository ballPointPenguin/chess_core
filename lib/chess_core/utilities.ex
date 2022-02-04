defmodule ChessCore.Utilities do
  @moduledoc """
  Helpful utilizies for interacting with a chess game.
  """

  @doc """
  Basic function that takes no arguments and returns a map of which squares
  are light and dark on a standard chess board.
  """

  @spec color_map :: %{{atom(), 1..8} => atom()}
  def color_map do
    for row <- 1..8, col <- 0..7, into: %{} do
      {{
         Enum.at([:a, :b, :c, :d, :e, :f, :g, :h], col),
         row
       }, if(Integer.mod(row, 2) == Integer.mod(col, 2), do: :light, else: :dark)}
    end
  end
end
