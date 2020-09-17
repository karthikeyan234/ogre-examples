defmodule GenstageExample.SQS.Server do  
  use GenServer

  ##########
  # Client API
  ##########
  def start_link(_opts) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def pull(count) do
    GenServer.call(GenstageExample.SQS.Server, {:pull, count}, 20000)
  end

  ##########
  # Server callbacks
  ##########
  def init(:ok) do
    IO.puts "Initalised SQS.Server"
    {:ok, 0}
  end

  def handle_call({:pull, count}, _from, runs) do
    IO.puts "Pulling #{count} events from server and runs is #{runs}"
    events = List.duplicate("ho", count)

    for event <- events do 
      IO.inspect(event)
      :timer.sleep(1000)
    end

    {:reply, {length(events), events}, runs + 1}
  end
end
