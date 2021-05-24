# Reborn

Reborn a simple phoenix web application that monitors the host system it runs on.

Features:

1. User Authentication using phx.gen.auth: https://hexdocs.pm/phx_gen_auth/overview.html
2. Using Bamboo for sending emails [Password-Reset Email, Email Confirmation]
   - Email local development and testing https://hexdocs.pm/bamboo/Bamboo.SentEmailViewerPlug.html
3. LiveView Dashboard
   - Metrics include a count to check how many times LiveView Dashboard page has been hit. (Not Completed)
   - added counter to "/welcome" route

Root page

"/home" -> LiveDashboard. Kept it default without any customization.
"/welcome" -> route for user to logout, settings, etc.

# Run:

    docker-compose up --build

    docker-compose run web mix ecto.create

In production - migrations

    heroku run:detached "POOL_SIZE=2 mix ecto.migrate"

   <!-- 
   To start your Phoenix server:

- Install dependencies with `mix deps.get`
- Create and migrate your database with `mix ecto.setup`
- Install Node.js dependencies with `npm install` inside the `assets` directory
- Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

- Official website: https://www.phoenixframework.org/
- Guides: https://hexdocs.pm/phoenix/overview.html
- Docs: https://hexdocs.pm/phoenix
- Forum: https://elixirforum.com/c/phoenix-forum
- Source: https://github.com/phoenixframework/phoenix -->
