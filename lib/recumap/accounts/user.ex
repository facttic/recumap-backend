defmodule Recumap.Accounts.User do
  use Ecto.Schema
  use Pow.Ecto.Schema

  schema "users" do
    field :name, :string
    field :is_verified, :boolean, default: false
    has_many :orgs, Recumap.Orgs.Org
    has_many :houses, Recumap.Houses.House
    has_many :resources, Recumap.Resources.Resource
    has_many :resource_types, Recumap.Resources.ResourceType

    pow_user_fields()
    timestamps()
  end

  def changeset(user_or_changeset, attrs) do
    user_or_changeset
    |> pow_changeset(attrs)
  end
end

