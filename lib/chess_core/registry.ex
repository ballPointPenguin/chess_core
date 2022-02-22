defmodule ChessCore.Registry do
  @moduledoc """
  The GenServer Registry for ChessCore.
  """

  use GenServer

  ## Client API

  @doc """
  Starts the registry.
  """
  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  @doc """
  Looks up the game pid for `id` stored in `server`.

  Returns `{:ok, pid}` if the game exists, `:error` otherwise.
  """
  def lookup(server, id) do
    GenServer.call(server, {:lookup, id})
  end

  @doc """
  Ensures there is a game associated with the given `id` in `server`.
  """
  def create(server, id) do
    GenServer.cast(server, {:create, id})
  end

  ## GenServer Callbacks

  @impl GenServer
  def init(:ok) do
    {:ok, %{}}
  end

  @impl GenServer
  def handle_call({:lookup, id}, _from, ids) do
    {:reply, Map.fetch(ids, id), ids}
  end

  @impl GenServer
  def handle_cast({:create, id}, ids) do
    if Map.has_key?(ids, id) do
      {:noreply, ids}
    else
      {:ok, game} = ChessCore.Game.start_link([])
      {:noreply, Map.put(ids, id, game)}
    end
  end
end

# Hex or Base64 encode the incrementing id integer for something
# more shareable.

# See https://github.com/TheFirstAvenger/elixir-accounts/blob/master/lib/accounts/registry.ex for example of starting/finding a named (or id'd) instance, returning {:ok, pid}

# Clustering not really necessary
