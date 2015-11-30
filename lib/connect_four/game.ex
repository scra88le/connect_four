defmodule ConnectFour.Game do
  use GenServer

  @registered_name ConnectFourGame

  def start_link do

  #The paramters for the start_link function are:
  # __MODULE__ is a macro that resolves at compile time to the name of the current module, that will contain the callbacks
  # %{} is an empty map for the initial state
  # A list for config, which only contrains the name of the regiestring process, so that we can find it later
  # Note, GenServer does not require an init function to work (unlike Supervisor)
    GenServer.start_link(__MODULE__, %{}, [name: @registered_name])
  end

  def print_board do
  	ConnectFour.Board.print
  end

  #CLIENT API
  def move(player,column) do
    case GenServer.call(@registered_name, {:move, player, column}) do
      :ok -> "Successful move for #{player} player in column #{column}"
    end
  end

  #SERVER CALLBACKS
  def handle_call({:move, player, column}, _from, state) do
    case ConnectFour.Board.place_token(player, column) do
      {:move_accepted} ->
        newstate = Map.put(state, :last_moved, player) # 1
        {:reply, :ok, newstate}                        # 2
    end
  end

end