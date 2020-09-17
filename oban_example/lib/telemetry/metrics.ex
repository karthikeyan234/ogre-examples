defmodule ObanExample.Telemetry.Metrics do 

  require Logger

  def setup() do
  	
  	events = [
  		[:phoenix, :request],
  		[:oban_example, :repo, :user_get]
  	]

     :telemetry.attach_many("oban-app-instrumenter", events, &handle_event/4, nil)

  end

  def handle_event([:phoenix, :request], %{duration: dur}, metadata, _config) do
    # do some stuff like log a message or report metrics to a service like StatsD

    context = %{
    	route: metadata.request_path,
    	duration: dur
    }
    #Honeybadger.notify("info", context)
    Logger.info("Received [:phoenix, :request] event. Request duration: #{dur}, Route: #{metadata.request_path}")
  end

  def handle_event([:oban_example, :repo, :user_get], measurements, metadata, config) do
   # IO.inspect binding()
    IO.inspect measurements
    IO.inspect metadata
  end

end