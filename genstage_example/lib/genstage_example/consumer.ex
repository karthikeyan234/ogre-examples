defmodule GenstageExample.Consumer do
	use GenStage 

	def start_link(_initial) do
		GenStage.start_link(__MODULE__, :state_doesnt_matter_for_me)
	end

	def init(state) do
		{:consumer, state, subscribe_to: [GenstageExample.ProducerConsumer]}
	end

	def handle_events(events, _from, state) do
		
		Process.sleep(9000)
		IO.inspect "New Round"
		for event <- events do
			IO.inspect({self(), event, state})
		end

		{:noreply, [], state}
	end
end