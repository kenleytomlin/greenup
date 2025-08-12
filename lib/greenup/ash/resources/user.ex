defmodule Greenup.Ash.Resources.User do
  use Ash.Resource,
    domain: Greenup.AshDomain,
    data_layer: AshPostgres.DataLayer,
    authorizers: [Ash.Policy.Authorizer]

  postgres do
    table("users")
    repo(Greenup.Repo)
  end

  identities do
    identity(:unique_email, [:email])
  end

  attributes do
    uuid_primary_key(:id)

    attribute :email, :string do
      allow_nil?(false)
      constraints(match: ~r/@/)
    end

    attribute :hashed_password, :string do
      allow_nil?(true)
      sensitive?(true)
    end

    attribute :is_admin, :boolean do
      allow_nil?(false)
      default(false)
    end

    create_timestamp(:inserted_at)
    update_timestamp(:updated_at)
  end

  actions do
    defaults([:read, :create, :update, :destroy])

    default_accept([:email, :hashed_password, :is_admin])
  end

  policies do
    policy always() do
      authorize_if(actor_attribute_equals(:is_admin, true))
    end
  end
end
