defmodule GenstageExample.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # {GenstageExample.Producer, 0},
      # {GenstageExample.ProducerConsumer, []},
      # %{
      #   id: 1,
      #   start: {GenstageExample.Consumer, :start_link, [[]]}
      # },
      # %{
      #   id: 2,
      #   start: {GenstageExample.Consumer, :start_link, [[]]}
      # }  
      {GenstageExample.SQS.Server, []},
      {GenstageExample.SQS.Producer, 0},
      {GenstageExample.SQS.Consumer, []},  
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: GenstageExample.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
