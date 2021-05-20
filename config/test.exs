use Mix.Config

database_url = System.get_env("DATABASE_URL")

# Only in tests, remove the complexity from the password hashing algorithm
config :bcrypt_elixir, :log_rounds, 1

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :reborn, Reborn.Repo,
  # username: "postgres",
  # password: "postgres",
  # database: "reborn_test#{System.get_env("MIX_TEST_PARTITION")}",
  # hostname: "localhost",
  url: String.replace(database_url, "?", "dev"),
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :reborn, RebornWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Mailgun - Configure bamboo to use the TestAdapter since we dont actually want to send an email during testing.
config :reborn, Reborn.Mailer, adapter: Bamboo.TestAdapter
