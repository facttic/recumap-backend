defmodule Recumap.Orgs.Org do
  use Ecto.Schema
  import Ecto.Changeset

  schema "orgs" do
    field :address, :string
    field :lat, :float
    field :long, :float
    field :description, :string
    field :name, :string
    field :public, :boolean, default: false
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(org, attrs) do
    org
    |> cast(attrs, [:name, :description, :address, :lat, :long, :public])
    |> validate_required([:name, :description, :address, :lat, :long, :public])
  end
end
