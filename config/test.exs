use Mix.Config

# Configure your database
config :recumap, Recumap.Repo,
  username: System.get_env("DB_USERNAME_TEST"),
  password: System.get_env("DB_PASSWORD_TEST"),
  database: System.get_env("DB_DATABASE_TEST"),
  hostname: System.get_env("DB_HOSTNAME_TEST"),
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :recumap, RecumapWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
