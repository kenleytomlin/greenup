defmodule Greenup.Ash.Resources.BotConfig do
  use Ash.Resource,
    domain: Greenup.AshDomain,
    data_layer: AshPostgres.DataLayer,
    authorizers: [Ash.Policy.Authorizer]

  postgres do
    table "bot_configs"
    repo Greenup.Repo
  end

  attributes do
    uuid_primary_key :id

    attribute :key, :string do
      allow_nil? false
    end

    attribute :value, :map do
      allow_nil? false
      default %{}
    end

    attribute :version, :integer do
      allow_nil? false
      default 1
    end

    create_timestamp :inserted_at
    update_timestamp :updated_at
  end

  actions do
    defaults [:read, :create, :update, :destroy]

    default_accept [:key, :value, :version]
  end

  policies do
    policy always() do
      authorize_if expr(actor(:is_admin) == true)
    end
  end
end
