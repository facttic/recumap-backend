defmodule RecumapWeb.API.HouseApiView do
  use RecumapWeb, :view
  alias RecumapWeb.API.HouseApiView

  def render("index.json", %{houses: houses}) do
    %{data: render_many(houses, HouseApiView, "house.json")}
  end

  def render("show.json", %{house: house}) do
    %{data: render_one(house, HouseApiView, "house.json")}
  end

  def render("house.json", %{house_api: house}) do
    %{id: house.id,
      responsible_name: house.responsible_name,
      responsible_surname: house.responsible_surname,
      responsible_dni: house.responsible_dni,
      responsible_phone: house.responsible_phone,
      address_street: house.address_street,
      address_number: house.address_number,
      address_between_streets: house.address_between_streets,
      address_neighborhood: house.address_neighborhood,
      address_locality: house.address_locality,
      lat: house.lat,
      long: house.long,
      number_of_members: house.number_of_members,
      number_of_minor_members: house.number_of_minor_members,
      number_of_older_members: house.number_of_older_members,
      healh_issues: house.healh_issues,
      earnings_formal_economy: house.earnings_formal_economy,
      earnings_affected_isolation: house.earnings_affected_isolation,
      benefited_by_social_plan: house.benefited_by_social_plan,
      family_emergency_plan: house.family_emergency_plan,
      food_help: house.food_help,
      attends_community_dining_room: house.attends_community_dining_room}
  end
end
