defmodule Recumap.Repo.Migrations.CreateResources do
  use Ecto.Migration

  def change do
    create table(:resources) do
      add :name, :string
      add :demographics, :string
      add :details, :text
      add :user_id, references(:users, on_delete: :nothing)
      add :resource_type_id, references(:resource_types, on_delete: :nothing)

      timestamps()
    end

    create index(:resources, [:user_id])
    create index(:resources, [:resource_type_id])
  end
end
