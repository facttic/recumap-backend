defmodule Recumap.Resources.Resource do
  use Ecto.Schema
  import Ecto.Changeset

  schema "resources" do
    field :name, :string
    field :address_between_streets, :string
    field :address_locality, :string
    field :address_neighborhood, :string
    field :address_number, :integer
    field :address_street, :string
    field :lat, :float
    field :long, :float
    field :details, :string
    field :responsible_dni, :string
    field :responsible_name, :string
    field :responsible_phone, :string
    field :responsible_surname, :string
    belongs_to :user, Recumap.Accounts.User
    belongs_to :resource_type, Recumap.Resources.ResourceType

    timestamps()
  end

  @doc false
  def changeset(resource, attrs) do
    resource
    |> cast(attrs, [
      :name,
      :responsible_name,
      :responsible_surname,
      :responsible_dni,
      :responsible_phone,
      :address_street,
      :address_number,
      :address_between_streets,
      :address_neighborhood,
      :address_locality,
      :lat,
      :long,
      :details,
      :resource_type_id
    ])
    |> validate_required([
      :name,
      :responsible_name,
      :responsible_surname,
      :responsible_dni,
      :responsible_phone,
      :address_street,
      :address_number,
      :address_between_streets,
      :address_neighborhood,
      :address_locality,
      :lat,
      :long,
      :details,
      :resource_type_id
    ])
  end
end
