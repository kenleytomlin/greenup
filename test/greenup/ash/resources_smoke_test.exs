defmodule Greenup.Ash.ResourcesSmokeTest do
  use Greenup.DataCase, async: true

  alias Greenup.Ash.Resources.BotConfig

  test "can create and read a BotConfig via Ash" do
    {:ok, created} =
      BotConfig
      |> Ash.Changeset.for_create(:create, %{key: "threshold", value: %{p: 1}, version: 1})
      |> Ash.create(actor: %{is_admin: true})

    assert created.key == "threshold"

    {:ok, [found]} = Ash.read(BotConfig, actor: %{is_admin: true})
    assert found.id == created.id
  end
end
