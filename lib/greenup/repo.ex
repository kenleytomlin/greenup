defmodule Greenup.Repo do
  use Ecto.Repo,
    otp_app: :greenup,
    adapter: Ecto.Adapters.Postgres
end
