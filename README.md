# Greenup

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Ash Framework Setup (Programmatic Only)

- Uses Ash 3.x with `ash_postgres` and `ash_phoenix`.
- Domain: `Greenup.AshDomain` with resources: `User`, `BotConfig`, `TradeLog`.
- Authorization: admin-only via Ash Policies.
- No Phoenix routes or controllers added in this phase; interact programmatically.

Commands:

```bash
mix ash_postgres.generate_migrations init_ash_resources
mix ecto.migrate
MIX_ENV=test mix ecto.migrate
mix run priv/repo/seeds.exs
mix test
```

Versions (from Dockerfile): Elixir 1.18.4, Erlang/OTP 28.0.1.

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
