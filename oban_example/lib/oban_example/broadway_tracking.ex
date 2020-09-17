defmodule BroadwayTracking do
  use Broadway

  alias Broadway.Message

 #  def start_link(_opts) do

	# Broadway.start_link(__MODULE__,
	#   name: __MODULE__,
	#   producers: [
	#     module: {BroadwaySQS.Producer,
	#       queue_url: "https://sqs.ap-south-1.amazonaws.com/341808978070/karthisqs",
	#       config: [
	#         access_key_id: "AKIAU7FLHDCLIDGWZFFS",
	#         secret_access_key: "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",
	#         region: "us-east-2"
	#       ]
	#     }
	#   ],
	#   processors: [
	#     default: []
	#   ],
	#   batchers: [
	#     default: [
	#       batch_size: 10,
	#       batch_timeout: 2000
	#     ]
	#   ]
	# )
 #  end

  @queue_name "https://sqs.ap-south-1.amazonaws.com/341808978070/karthisqs"
    
  def start_link(_opts) do
    # start_link opts https://hexdocs.pm/broadway/Broadway.html#start_link/2
    Broadway.start_link(__MODULE__,
      name: __MODULE__,
      # opts https://hexdocs.pm/broadway/Broadway.html#start_link/2-producers-options
      producers: [
        default: [
          module: {
            BroadwaySQS.Producer,
            queue_name: "341808978070/karthisqs"
          }
        ]
      ],
      # opts https://hexdocs.pm/broadway/Broadway.html#start_link/2-processors-options
      processors: [
        default: []
      ],
      # opts https://hexdocs.pm/broadway/Broadway.html#start_link/2-batchers-options
      batchers: [
        batch_a: [
          batch_size: 10,
          batch_timeout: 10_000
        ],
       batch_b: [
          batch_size: 10,
          batch_timeout: 10_000          
       ]
      ]
    )
  end
  @impl true
  def handle_message(_, %Message{data: data} = message, _) do
  	IO.inspect "HANDLE_MESSAGE"
  	IO.inspect message

        message
        |> Message.update_data(fn (data) ->
            #process the data 
            # return what you want stored as data in Message
            IO.inspect("data coming")
            IO.inspect data
            Process.sleep(6000)
            new_id = :rand.uniform(900)
            IO.inspect new_id
             #ProduceJobs.create_message(new_id)
             data
        end)
        |> IO.inspect(label: "FIND")
        |> Message.put_batcher(:batch_a)
       # OR case 2
        # message
        # |> Message.update_data(fn (data) ->
        #     #process the data 
        #     # return what you want stored as data in Message
        # end)
        # |> Message.put_batcher(:batch_b)
  end

  def handle_batch(:batch_a, messages, _, _) do
    messages 
    |> Enum.map(fn message -> message.data end)
    |> IO.inspect(label: "batch_a")   

     # take action with processed data from handle_message
     
    messages
    {:ok, "cool"}
    # return messages and they will be marked as complete on SQS
    # if error is raised in this callback, it will be logged and all messages in batch will be marked as failed
    # you may want to set up a dead letter queue on SQS to handle failed messages
  end

  # def handle_batch(:batch_b, messages, _, _) do
  #   messages 
  #   |> Enum.map(fn message -> message.data end)
  #   |> IO.inspect(label: "batch_b")   

  #    # take action with processed data from handle_message

  #   messages
  #   # return messages and they will be marked as complete on SQS
  #   # if error is raised in this callback, it will be logged and all messages in batch will be marked as failed
  #   # you may want to set up a dead letter queue on SQS to handle failed messages
  # end

end