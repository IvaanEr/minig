# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :minig,
  ecto_repos: [Minig.Repo]

# Configures the endpoint
config :minig, MinigWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "SzfWQAjnjgxx/vamc3vBKbby0jvt5Us5cskK12T2jdjDNa5dViBkn1g5WgLnw7o8",
  render_errors: [view: MinigWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Minig.PubSub,
  live_view: [signing_salt: "umgbD7fk"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
