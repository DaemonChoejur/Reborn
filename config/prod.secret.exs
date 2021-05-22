# In this file, we load production configuration and secrets
# from environment variables. You can also hardcode secrets,
# although such is generally not recommended and you have to
# remember to add this file to your .gitignore.
use Mix.Config

database_url =
  System.get_env("DATABASE_URL") ||
    raise """
    environment variable DATABASE_URL is missing.
    For example: ecto://USER:PASS@HOST/DATABASE
    """

domain =
  System.get_env("DOMAIN") ||
    raise """
    environment variable DOMAIN is missing.
    """

api_key =
  System.get_env("API_KEY") ||
    raise """
    environment variable API_KEY is missing.
    """

config :reborn, Reborn.Repo,
  ssl: true,
  url: database_url,
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10")

secret_key_base =
  System.get_env("SECRET_KEY_BASE") ||
    raise """
    environment variable SECRET_KEY_BASE is missing.
    You can generate one by calling: mix phx.gen.secret
    """

config :reborn, RebornWeb.Endpoint,
  # url: [
  #   host: "reborn-alphanapster.herokuapp.com",
  #   port: String.to_integer(System.fetch_env!("PORT"))
  # ],
  # check_origin: ["//reborn-alphanapster.herokuapp.com"],
  http: [
    port: String.to_integer(System.get_env("PORT") || "4000"),
    transport_options: [socket_opts: []]
  ],
  # server: true,
  # code_reloader: false,
  secret_key_base: secret_key_base

# ## Using releases (Elixir v1.9+)
#
# If you are doing OTP releases, you need to instruct Phoenix
# to start each relevant endpoint:
#
#     config :reborn, RebornWeb.Endpoint, server: true
#
# Then you can assemble a release by calling `mix release`.
# See `mix help release` for more information.

# Mailgun config to use environment vars for prod.
config :reborn, Reborn.Mailer,
  adapter: Bamboo.MailgunAdapter,
  domain: domain,
  api_key: api_key