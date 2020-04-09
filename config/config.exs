# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :recumap,
  ecto_repos: [Recumap.Repo]

# Configures the endpoint
config :recumap, RecumapWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "N5vUg81475XfoYubuBELC/9tmSCvONnt5PkAnNydomZcATZyGCkRXscHfdv6pnhg",
  render_errors: [view: RecumapWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Recumap.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :torch,
  otp_app: :recumap,
  template_format: "eex"

config :recumap, :pow,
  user: Recumap.Users.User,
  repo: Recumap.Repo


# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
