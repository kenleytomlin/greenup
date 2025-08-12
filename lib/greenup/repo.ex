defmodule Greenup.Repo do
  use AshPostgres.Repo, otp_app: :greenup

  @doc """
  PostgreSQL extensions required by Ash/AshPostgres migrations.
  """
  def installed_extensions do
    ["uuid-ossp", "ash-functions"]
  end

  @doc """
  Minimum supported PostgreSQL version for this repo.
  """
  def min_pg_version do
    %Version{major: 14, minor: 0, patch: 0}
  end
end
