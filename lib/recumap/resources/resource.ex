defmodule Recumap.Resources.Resource do
  use Ecto.Schema
  import Ecto.Changeset

  schema "resources" do
    field :demographics, :string
    field :details, :string
    field :name, :string
    field :user_id, :id
    field :resource_type_id, :id

    timestamps()
  end

  @doc false
  def changeset(resource, attrs) do
    resource
    |> cast(attrs, [:name, :demographics, :details])
    |> validate_required([:name, :demographics, :details])
  end
end
