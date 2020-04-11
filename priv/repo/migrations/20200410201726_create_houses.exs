defmodule Recumap.Repo.Migrations.CreateHouses do
  use Ecto.Migration

  def change do
    create table(:houses) do
      add :responsible_name, :string
      add :responsible_surname, :string
      add :responsible_dni, :string
      add :responsible_phone, :string
      add :address_street, :string
      add :address_number, :integer
      add :address_between_streets, :string
      add :address_neighborhood, :string
      add :address_locality, :string
      add :lat, :float
      add :long, :float
      add :number_of_members, :integer
      add :number_of_minor_members, :integer
      add :number_of_older_members, :integer
      add :healh_issues, :boolean, default: false, null: false
      add :earnings_formal_economy, :boolean, default: false, null: false
      add :earnings_affected_isolation, :boolean, default: false, null: false
      add :benefited_by_social_plan, :boolean, default: false, null: false
      add :family_emergency_plan, :boolean, default: false, null: false
      add :food_help, :boolean, default: false, null: false
      add :attends_community_dining_room, :boolean, default: false, null: false
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:houses, [:user_id])
  end
end
