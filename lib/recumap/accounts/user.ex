defmodule Recumap.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :is_verified, :boolean, default: false
    field :name, :string
    field :password_hash, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :is_verified, :password_hash])
    |> validate_required([:name, :email, :is_verified, :password_hash])
    |> unique_constraint(:email)
  end
end
