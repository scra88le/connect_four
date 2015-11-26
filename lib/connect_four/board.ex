defmodule ConnectFour.Board do
  use Supervisor

  @registered_name ConnectFourBoard
  @last_row 6
  @last_column 7

  #Note that is is a supervisor, and therefore does not hold state. Therefore
  #there is an empty list (for parameters) in the start_link call
  #as with GenServer there is a list for config where we have registered the process
  # with a name so we can find it across the code if we need to
  # this is now called in the parent ConnectFour (application) as a worker

  def start_link do
    Supervisor.start_link(__MODULE__, :no_args, [name: @registered_name])
  end

  def init(:no_args) do
    children =
      for t <- spaces do
        worker(ConnectFour.Space, [t], id: t)
      end
      supervise(children, strategy: :one_for_one)
  end

  def spaces do
    for row <- 1..@last_row, column <- 1..@last_column, do: {row, column}
  end

end