defmodule Greenup.Ash.PoliciesTest do
  use Greenup.DataCase, async: true

  alias Greenup.Ash.Resources.BotConfig

  test "non-admin is denied" do
    assert {:error, %Ash.Error.Forbidden{}} =
             BotConfig
             |> Ash.Changeset.for_create(:create, %{key: "x", value: %{}, version: 1})
             |> Ash.create(actor: %{is_admin: false})
  end

  test "admin is allowed" do
    assert {:ok, _} =
             BotConfig
             |> Ash.Changeset.for_create(:create, %{key: "y", value: %{}, version: 1})
             |> Ash.create(actor: %{is_admin: true})
  end
end
