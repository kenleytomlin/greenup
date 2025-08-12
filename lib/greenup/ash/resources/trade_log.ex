defmodule Greenup.Ash.Resources.TradeLog do
  use Ash.Resource,
    domain: Greenup.AshDomain,
    data_layer: AshPostgres.DataLayer,
    authorizers: [Ash.Policy.Authorizer]

  postgres do
    table "trade_logs"
    repo Greenup.Repo
  end

  attributes do
    uuid_primary_key :id

    attribute :market_id, :string do
      allow_nil? false
    end

    attribute :side, :string do
      allow_nil? false
    end

    attribute :stake, :decimal do
      allow_nil? false
    end

    attribute :price, :decimal do
      allow_nil? false
    end

    attribute :result_pnl, :decimal do
      allow_nil? true
    end

    attribute :occurred_at, :utc_datetime do
      allow_nil? false
    end

    create_timestamp :inserted_at
    update_timestamp :updated_at
  end

  actions do
    defaults [:read, :create, :update, :destroy]

    default_accept [:market_id, :side, :stake, :price, :result_pnl, :occurred_at]
  end

  policies do
    policy always() do
      authorize_if expr(actor(:is_admin) == true)
    end
  end
end
