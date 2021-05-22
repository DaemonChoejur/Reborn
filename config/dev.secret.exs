import Config

# using the localadapter tha bamboo provides for testing mail
config :reborn, Reborn.Mailer, adapter: Bamboo.LocalAdapter
# adapter: Bamboo.MailgunAdapter,
# domain: "mg.myapp.com",
# api_key: "my-api-key"
