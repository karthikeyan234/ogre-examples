defmodule GenstageExample.SQS.Consumer do 
  use GenStage

  ##########
  # Client API
  ##########
  # def start_link(_normal) do
  #   GenStage.start_link(__MODULE__, :ok)
  # end
def start_link(_initial) do
	GenStage.start_link(__MODULE__, :state_doesnt_matter_for_me)
end

  ##########
  # Server callbacks
  ##########

  def init(state) do
    IO.puts "Initalised SQS.Consumer #{state}"
    IO.puts "send events from producer"
    {:consumer, state, subscribe_to: [{GenstageExample.SQS.Producer, min_demand: 2, max_demand: 10}]}
  end

  def handle_events(events, _from, state) do
    :timer.sleep(1000)

    event_string = Enum.join(events, ", ")
    IO.puts "Consumed: #{event_string}"

    {:noreply, [], state}
  end
end

# defmodule GenstageExample.Consumer do
# 	use GenStage 

# 	def start_link(_initial) do
# 		GenStage.start_link(__MODULE__, :state_doesnt_matter_for_me)
# 	end

# 	def init(state) do
# 		{:consumer, state, subscribe_to: [GenstageExample.ProducerConsumer]}
# 	end

# 	def handle_events(events, _from, state) do
		
# 		Process.sleep(9000)
# 		IO.inspect "New Roundddddddddddddddddddddddddddddd"
# 		for event <- events do
# 			IO.inspect({self(), event, state})
# 		end

# 		{:noreply, [], state}
# 	end
# end
