# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :oban_example,
  ecto_repos: [ObanExample.Repo]

# Configures the endpoint
config :oban_example, ObanExampleWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "y0DPQrAD2UDdx4a5TpS6HoPbizd8sNKz5yFMC72faWIozIgc0aj431Lf2XjDyS2Z",
  render_errors: [view: ObanExampleWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: ObanExample.PubSub,
  live_view: [signing_salt: "XJj5lj09"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :ex_aws,
  access_key_id: [{:system, "AWS_ACCESS_KEY_ID"}, :instance_role],
  secret_access_key: [{:system, "AWS_SECRET_ACCESS_KEY"}, :instance_role],
  region: "ap-south-1"

config :honeybadger,
  api_key: "f7f2630d",
  environment_name: :dev

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
