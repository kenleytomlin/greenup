alias Greenup.Ash.Resources.{User, BotConfig}

admin_email = System.get_env("ADMIN_EMAIL") || "admin@example.com"

{:ok, _admin} =
  User
  |> Ash.Changeset.for_create(:create, %{email: admin_email, is_admin: true})
  |> Ash.create()

{:ok, _cfg} =
  BotConfig
  |> Ash.Changeset.for_create(:create, %{key: "bot.enabled", value: %{enabled: true}, version: 1})
  |> Ash.create()

IO.puts("Seeded admin user #{admin_email} and initial bot config.")
