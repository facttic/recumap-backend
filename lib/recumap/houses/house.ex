defmodule Recumap.Houses.House do
  use Ecto.Schema
  import Ecto.Changeset

  schema "houses" do
    field :address_between_streets, :string
    field :address_locality, :string
    field :address_neighborhood, :string
    field :address_number, :integer
    field :address_street, :string
    field :attends_community_dining_room, :boolean, default: false
    field :benefited_by_social_plan, :boolean, default: false
    field :demographics, :string
    field :earnings_affected_isolation, :boolean, default: false
    field :earnings_formal_economy, :boolean, default: false
    field :family_emergency_plan, :boolean, default: false
    field :food_help, :boolean, default: false
    field :healh_issues, :boolean, default: false
    field :number_of_members, :integer
    field :number_of_minor_members, :integer
    field :number_of_older_members, :integer
    field :responsible_dni, :string
    field :responsible_name, :string
    field :responsible_phone, :string
    field :responsible_surname, :string
    field :org_id, :id

    timestamps()
  end

  @doc false
  def changeset(house, attrs) do
    house
    |> cast(attrs, [:responsible_name, :responsible_surname, :responsible_dni, :responsible_phone, :address_street, :address_number, :address_between_streets, :address_neighborhood, :address_locality, :demographics, :number_of_members, :number_of_minor_members, :number_of_older_members, :healh_issues, :earnings_formal_economy, :earnings_affected_isolation, :benefited_by_social_plan, :family_emergency_plan, :food_help, :attends_community_dining_room])
    |> validate_required([:responsible_name, :responsible_surname, :responsible_dni, :responsible_phone, :address_street, :address_number, :address_between_streets, :address_neighborhood, :address_locality, :demographics, :number_of_members, :number_of_minor_members, :number_of_older_members, :healh_issues, :earnings_formal_economy, :earnings_affected_isolation, :benefited_by_social_plan, :family_emergency_plan, :food_help, :attends_community_dining_room])
  end
end
