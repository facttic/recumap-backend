defmodule Recumap.Accounts.User do
  use Ecto.Schema
  use Pow.Ecto.Schema

  schema "users" do
    field :email, :string
    field :is_verified, :boolean, default: false
    field :name, :string
    field :password_confirmation, :string, virtual: true
    field :password_hash, :string
    pow_user_fields()

    timestamps()
  end

end
