# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :blog_phx,
  ecto_repos: [BlogPhx.Repo]

# Configures the endpoint
config :blog_phx, BlogPhxWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "fK85AgsMCCDFjuMIhPLolvsI+jtdHAuoVseHseq721NZZHXfRI/sOTijS79xC2x0",
  render_errors: [view: BlogPhxWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: BlogPhx.PubSub,
  live_view: [signing_salt: "kwh9OvXn"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :ueberauth, Ueberauth,
  providers: [
    google: {Ueberauth.Strategy.Google, []}
  ]

config :ueberauth, Ueberauth.Strategy.Google.OAuth,
  client_id: System.get_env("GOOGLE_CLIENT_ID"),
  client_secret: System.get_env("GOOGLE_CLIENT_SECRET")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
