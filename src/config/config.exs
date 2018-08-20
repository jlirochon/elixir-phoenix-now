# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :now, NowWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "0CVS+E9rxF96RHcbqfcQVRUlIFIVRweGi0LR0a6PS6LY4zfD+WgQUa9t3xAIdNW9",
  render_errors: [view: NowWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Now.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
