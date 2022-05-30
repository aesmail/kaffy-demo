# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :bakery,
  ecto_repos: [Bakery.Repo]

# Configures the endpoint
config :bakery, BakeryWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "m1Xx8LZu222KQGCR3IClm/tbCzXkyHqiWYla2Fkk+rYwR7iXeo98bs/2GjTNaEBf",
  render_errors: [view: BakeryWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Bakery.PubSub,
  live_view: [signing_salt: "JUpvO0NV"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :kaffy,
  admin_title: "Bakery",
  hide_dashboard: false,
  # home_page: [schema: ["products", "product"]],
  otp_app: :bakery,
  ecto_repo: Bakery.Repo,
  router: BakeryWeb.Router,
  data_adapter: Kaffy.DataAdapters.Ecto.EctoAdapter,
  # scheduled_tasks: [
  #   Bakery.Kaffy.Tasks
  # ],
  extensions: [
    Bakery.Kaffy.Extension
  ]

# resources: &Bakery.Kaffy.Resources.build_resources/1

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
