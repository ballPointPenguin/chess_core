defmodule ChessCore.Position do
  @moduledoc """
  Defines all the aspects of a chess board, pieces, which color to play,
  and status of the game.
  """

  defstruct board: %{},
            active_color: "",
            castling: "",
            en_passant: "",
            halfmove: 0,
            move: 1

  @pieces [:R, :N, :B, :Q, :K, :P, :r, :n, :b, :q, :k, :p]

  @doc """
    Parse FEN string and return a ChessCore.Position struct with the details
    of the position.
  """

  @spec parse_fen(String.t()) :: %__MODULE__{}
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
