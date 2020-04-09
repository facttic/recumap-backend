defmodule Recumap.Resources.ResourceType do
  use Ecto.Schema
  import Ecto.Changeset

  schema "resource_types" do
    field :description, :string
    field :name, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(resource_type, attrs) do
    resource_type
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end
