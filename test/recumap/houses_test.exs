defmodule Recumap.HousesTest do
  use Recumap.DataCase

  alias Recumap.Houses

  describe "houses" do
    alias Recumap.Houses.House

    @valid_attrs %{address_between_streets: "some address_between_streets", address_locality: "some address_locality", address_neighborhood: "some address_neighborhood", address_number: 42, address_street: "some address_street", attends_community_dining_room: true, benefited_by_social_plan: true, demographics: "some demographics", earnings_affected_isolation: true, earnings_formal_economy: true, family_emergency_plan: true, food_help: true, healh_issues: true, number_of_members: 42, number_of_minor_members: 42, number_of_older_members: 42, responsible_dni: "some responsible_dni", responsible_name: "some responsible_name", responsible_phone: "some responsible_phone", responsible_surname: "some responsible_surname"}
    @update_attrs %{address_between_streets: "some updated address_between_streets", address_locality: "some updated address_locality", address_neighborhood: "some updated address_neighborhood", address_number: 43, address_street: "some updated address_street", attends_community_dining_room: false, benefited_by_social_plan: false, demographics: "some updated demographics", earnings_affected_isolation: false, earnings_formal_economy: false, family_emergency_plan: false, food_help: false, healh_issues: false, number_of_members: 43, number_of_minor_members: 43, number_of_older_members: 43, responsible_dni: "some updated responsible_dni", responsible_name: "some updated responsible_name", responsible_phone: "some updated responsible_phone", responsible_surname: "some updated responsible_surname"}
    @invalid_attrs %{address_between_streets: nil, address_locality: nil, address_neighborhood: nil, address_number: nil, address_street: nil, attends_community_dining_room: nil, benefited_by_social_plan: nil, demographics: nil, earnings_affected_isolation: nil, earnings_formal_economy: nil, family_emergency_plan: nil, food_help: nil, healh_issues: nil, number_of_members: nil, number_of_minor_members: nil, number_of_older_members: nil, responsible_dni: nil, responsible_name: nil, responsible_phone: nil, responsible_surname: nil}

    def house_fixture(attrs \\ %{}) do
      {:ok, house} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Houses.create_house()

      house
    end

    test "paginate_houses/1 returns paginated list of houses" do
      for _ <- 1..20 do
        house_fixture()
      end

      {:ok, %{houses: houses} = page} = Houses.paginate_houses(%{})

      assert length(houses) == 15
      assert page.page_number == 1
      assert page.page_size == 15
      assert page.total_pages == 2
      assert page.total_entries == 20
      assert page.distance == 5
      assert page.sort_field == "inserted_at"
      assert page.sort_direction == "desc"
    end

    test "list_houses/0 returns all houses" do
      house = house_fixture()
      assert Houses.list_houses() == [house]
    end

    test "get_house!/1 returns the house with given id" do
      house = house_fixture()
      assert Houses.get_house!(house.id) == house
    end

    test "create_house/1 with valid data creates a house" do
      assert {:ok, %House{} = house} = Houses.create_house(@valid_attrs)
      assert house.address_between_streets == "some address_between_streets"
      assert house.address_locality == "some address_locality"
      assert house.address_neighborhood == "some address_neighborhood"
      assert house.address_number == 42
      assert house.address_street == "some address_street"
      assert house.attends_community_dining_room == true
      assert house.benefited_by_social_plan == true
      assert house.demographics == "some demographics"
      assert house.earnings_affected_isolation == true
      assert house.earnings_formal_economy == true
      assert house.family_emergency_plan == true
      assert house.food_help == true
      assert house.healh_issues == true
      assert house.number_of_members == 42
      assert house.number_of_minor_members == 42
      assert house.number_of_older_members == 42
      assert house.responsible_dni == "some responsible_dni"
      assert house.responsible_name == "some responsible_name"
      assert house.responsible_phone == "some responsible_phone"
      assert house.responsible_surname == "some responsible_surname"
    end

    test "create_house/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Houses.create_house(@invalid_attrs)
    end

    test "update_house/2 with valid data updates the house" do
      house = house_fixture()
      assert {:ok, house} = Houses.update_house(house, @update_attrs)
      assert %House{} = house
      assert house.address_between_streets == "some updated address_between_streets"
      assert house.address_locality == "some updated address_locality"
      assert house.address_neighborhood == "some updated address_neighborhood"
      assert house.address_number == 43
      assert house.address_street == "some updated address_street"
      assert house.attends_community_dining_room == false
      assert house.benefited_by_social_plan == false
      assert house.demographics == "some updated demographics"
      assert house.earnings_affected_isolation == false
      assert house.earnings_formal_economy == false
      assert house.family_emergency_plan == false
      assert house.food_help == false
      assert house.healh_issues == false
      assert house.number_of_members == 43
      assert house.number_of_minor_members == 43
      assert house.number_of_older_members == 43
      assert house.responsible_dni == "some updated responsible_dni"
      assert house.responsible_name == "some updated responsible_name"
      assert house.responsible_phone == "some updated responsible_phone"
      assert house.responsible_surname == "some updated responsible_surname"
    end

    test "update_house/2 with invalid data returns error changeset" do
      house = house_fixture()
      assert {:error, %Ecto.Changeset{}} = Houses.update_house(house, @invalid_attrs)
      assert house == Houses.get_house!(house.id)
    end

    test "delete_house/1 deletes the house" do
      house = house_fixture()
      assert {:ok, %House{}} = Houses.delete_house(house)
      assert_raise Ecto.NoResultsError, fn -> Houses.get_house!(house.id) end
    end

    test "change_house/1 returns a house changeset" do
      house = house_fixture()
      assert %Ecto.Changeset{} = Houses.change_house(house)
    end
  end
end
