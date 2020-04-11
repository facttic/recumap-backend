defmodule Recumap.Repo.Migrations.CreateOrgs do
  use Ecto.Migration

  def change do
    create table(:orgs) do
      add :name, :string
      add :description, :string
      add :address, :string
      add :lat, :float
      add :long, :float
      add :public, :boolean, default: false, null: false
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:orgs, [:name])
    create index(:orgs, [:user_id])
  end
end
