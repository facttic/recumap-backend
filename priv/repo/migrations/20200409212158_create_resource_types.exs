defmodule Recumap.Repo.Migrations.CreateResourceTypes do
  use Ecto.Migration

  def change do
    create table(:resource_types) do
      add :name, :string
      add :description, :text
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:resource_types, [:user_id])
  end
end
