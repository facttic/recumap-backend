defmodule Recumap.Accounts.User do
  use Ecto.Schema
  use Pow.Ecto.Schema

  schema "users" do
    field :name, :string
    field :is_verified, :boolean, default: false

    pow_user_fields()
    timestamps()
  end
end
