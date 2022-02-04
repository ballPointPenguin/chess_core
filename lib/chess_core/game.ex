defmodule ChessCore.Game do
  @moduledoc """
  Defines the Game itself, which can receive move attempts from players, and
  interacts with the underlying erlang binbo chess library.
  """

  alias ChessCore.Position
  alias ChessCore.Utilities

  defstruct position: %Position{},
            player_1: "Player 1",
            player_2: "Player 2",
            white_pieces: :player_1,
            moves: []

  @doc """
    Creates a new game with 2 named players and a game position. Defaults to
    "Player 1" and "Player 2". Defaults to standard initial chess position.
  """

  @spec new_game :: %__MODULE__{}
  def new_game do
    new_game("Player 1", "Player 2", Utilities.initial_fen())
  end

  @spec new_game(String.t(), String.t()) :: %__MODULE__{}
  def new_game(player_1, player_2) do
    new_game(player_1, player_2, Utilities.initial_fen())
  end

  @spec new_game(String.t(), String.t(), String.t()) :: %__MODULE__{}
  def new_game(player_1, player_2, fen) do
    %__MODULE__{player_1: player_1, player_2: player_2, position: Position.parse_fen(fen)}
  end

  @spec attempt_move(%__MODULE__{}, String.t()) :: {:ok, %__MODULE__{}} | {:error, String.t()}
  def attempt_move(%{moves: moves} = game, move) do
    {:ok, %{game | moves: [move | moves]}}
  end
end
