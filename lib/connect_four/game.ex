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

end