defmodule ProduceJobs do 

  
  def create_message(num) do
  	message = make_message(num)
  	send_messages(message, "karthisqs")
  end

  defp make_message(num) do
    [[id: UUID.uuid4(), message_body: "{'id':#{num}}"]]
  end

  defp send_messages(messages, queue) do
    IO.inspect "Send messages to Queue AWS"
    queue
    |> ExAws.SQS.send_message_batch(messages)
    |> IO.inspect(label: "Before sending request")
    |> ExAws.request(region: "ap-south-1")
    |> IO.inspect(label: "coming response")
  end

end