defmodule ChessCore do
  @moduledoc """
  Documentation for `ChessCore`.
  """

  defstruct board: %{},
            active_color: "",
            castling: "",
            en_passant: "",
            halfmove: 0,
            move: 1

  @pieces [:R, :N, :B, :Q, :K, :P, :r, :n, :b, :q, :k, :p]

  @doc """
    Parse FEN.

    ## Examples

      iex> ChessCore.parse_fen("rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1")
      %Chess{
        active_color: :w,
        board: %{
          {:e, 1} => :K,
          {:g, 1} => :N,
          {:a, 3} => nil,
          ...
        },
        castling: "KQkq",
        en_passant: "-",
        halfmove: 0,
        move: 1
      }
  """

  @spec parse_fen(String.t()) :: __MODULE__.t()
  def parse_fen(fen) do
    [board, active_color, castling, en_passant, halfmove, move] = String.split(fen)

    %__MODULE__{
      board: fen_board(board),
      active_color: if(active_color == "b", do: :b, else: :w),
      castling: castling,
      en_passant: en_passant,
      halfmove: String.to_integer(halfmove),
      move: String.to_integer(move)
    }
  end

  @doc """
  Color Map.

  ## Examples

      iex> ChessCore.color_map()
      %{
        {:a, 1} => :dark,
        {:b, 1} => :light,
        {:c, 1} => :dark,
        ...
      }

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

  defp fen_board(fen_position) do
    fen_position
    |> String.split("/")
    |> Enum.map(&String.split(&1, "", trim: true))
    |> Enum.reverse()
    |> List.flatten()
    |> Enum.map(&fen_char_to_pieces/1)
    |> List.flatten()
    |> make_board()
  end

  defp fen_char_to_pieces(char) do
    cond do
      String.match?(char, ~r/[1-8]/) ->
        List.duplicate(nil, String.to_integer(char))

      char in Enum.map(@pieces, &Atom.to_string/1) ->
        String.to_existing_atom(char)

      true ->
        nil
    end
  end

  defp make_board(pieces) do
    for row <- 1..8, col <- 0..7, into: %{} do
      index = col + (row - 1) * 8

      {{
         Enum.at([:a, :b, :c, :d, :e, :f, :g, :h], col),
         row
       }, Enum.at(pieces, index)}
    end
  end
end
