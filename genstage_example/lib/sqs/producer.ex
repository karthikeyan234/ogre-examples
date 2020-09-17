defmodule GenstageExample.SQS.Producer do
  use GenStage

  ##########
  # Client API
  ##########
  def start_link(initial \\ 0) do
    GenStage.start_link(__MODULE__, initial, name: __MODULE__)
  end


  ##########
  # Server callbacks
  ##########

  def init(initial) do
    IO.puts "Initalised SQS.Producer"
    {:producer, initial}
  end

  def handle_demand(demand, state) when demand > 0 do
    IO.puts "SQS.Producer handling demand of #{demand} and #{state}"

    # Make a call to the server for the required number of events,
    # accounting for previously unsatisfied demand
    new_demand = demand + state

    {count, events} = take(new_demand)

    # Events will always be returned from this server,
    # but if `events` was empty, state will be updated to the new demand level
    {:noreply, events, new_demand - count}
  end

  defp take(demand) do
    # Return a list no longer than the demand value
    IO.puts "Asking for #{demand} events"

    {count, events} = GenstageExample.SQS.Server.pull(demand)

    IO.puts "Received #{count} events"
    {count, events}
  end
end
