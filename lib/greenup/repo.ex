defmodule Greenup.Repo do
  use AshPostgres.Repo, otp_app: :greenup

  @doc """
  PostgreSQL extensions required by Ash/AshPostgres migrations.
  """
  def installed_extensions do
    ["uuid-ossp"]
  end
end
