defmodule Recumap.Repo.Migrations.CreateResources do
  use Ecto.Migration

  def change do
    create table(:resources) do
      add :responsible_name, :string
      add :responsible_surname, :string
      add :responsible_dni, :string
      add :responsible_phone, :string
      add :address_street, :string
      add :address_number, :integer
      add :address_between_streets, :string
      add :address_neighborhood, :string
      add :address_locality, :string
      add :name, :string
      add :lat, :float
      add :long, :float
      add :details, :text
      add :user_id, references(:users, on_delete: :nothing)
      add :resource_type_id, references(:resource_types, on_delete: :nothing)

      timestamps()
    end

    create index(:resources, [:user_id])
    create index(:resources, [:resource_type_id])
  end
end
