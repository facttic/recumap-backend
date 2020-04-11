defmodule RecumapWeb.HouseControllerTest do
  use RecumapWeb.ConnCase

  alias Recumap.Houses

  @create_attrs %{address_between_streets: "some address_between_streets", address_locality: "some address_locality", address_neighborhood: "some address_neighborhood", address_number: 42, address_street: "some address_street", attends_community_dining_room: true, benefited_by_social_plan: true, demographics: "some demographics", earnings_affected_isolation: true, earnings_formal_economy: true, family_emergency_plan: true, food_help: true, healh_issues: true, number_of_members: 42, number_of_minor_members: 42, number_of_older_members: 42, responsible_dni: "some responsible_dni", responsible_name: "some responsible_name", responsible_phone: "some responsible_phone", responsible_surname: "some responsible_surname"}
  @update_attrs %{address_between_streets: "some updated address_between_streets", address_locality: "some updated address_locality", address_neighborhood: "some updated address_neighborhood", address_number: 43, address_street: "some updated address_street", attends_community_dining_room: false, benefited_by_social_plan: false, demographics: "some updated demographics", earnings_affected_isolation: false, earnings_formal_economy: false, family_emergency_plan: false, food_help: false, healh_issues: false, number_of_members: 43, number_of_minor_members: 43, number_of_older_members: 43, responsible_dni: "some updated responsible_dni", responsible_name: "some updated responsible_name", responsible_phone: "some updated responsible_phone", responsible_surname: "some updated responsible_surname"}
  @invalid_attrs %{address_between_streets: nil, address_locality: nil, address_neighborhood: nil, address_number: nil, address_street: nil, attends_community_dining_room: nil, benefited_by_social_plan: nil, demographics: nil, earnings_affected_isolation: nil, earnings_formal_economy: nil, family_emergency_plan: nil, food_help: nil, healh_issues: nil, number_of_members: nil, number_of_minor_members: nil, number_of_older_members: nil, responsible_dni: nil, responsible_name: nil, responsible_phone: nil, responsible_surname: nil}

  def fixture(:house) do
    {:ok, house} = Houses.create_house(@create_attrs)
    house
  end

  describe "index" do
    test "lists all houses", %{conn: conn} do
      conn = get conn, Routes.house_path(conn, :index)
      assert html_response(conn, 200) =~ "Houses"
    end
  end

  describe "new house" do
    test "renders form", %{conn: conn} do
      conn = get conn, Routes.house_path(conn, :new)
      assert html_response(conn, 200) =~ "New House"
    end
  end

  describe "create house" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, Routes.house_path(conn, :create), house: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.house_path(conn, :show, id)

      conn = get conn, Routes.house_path(conn, :show, id)
      assert html_response(conn, 200) =~ "House Details"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, Routes.house_path(conn, :create), house: @invalid_attrs
      assert html_response(conn, 200) =~ "New House"
    end
  end

  describe "edit house" do
    setup [:create_house]

    test "renders form for editing chosen house", %{conn: conn, house: house} do
      conn = get conn, Routes.house_path(conn, :edit, house)
      assert html_response(conn, 200) =~ "Edit House"
    end
  end

  describe "update house" do
    setup [:create_house]

    test "redirects when data is valid", %{conn: conn, house: house} do
      conn = put conn, Routes.house_path(conn, :update, house), house: @update_attrs
      assert redirected_to(conn) == Routes.house_path(conn, :show, house)

      conn = get conn, Routes.house_path(conn, :show, house)
      assert html_response(conn, 200) =~ "some updated address_between_streets"
    end

    test "renders errors when data is invalid", %{conn: conn, house: house} do
      conn = put conn, Routes.house_path(conn, :update, house), house: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit House"
    end
  end

  describe "delete house" do
    setup [:create_house]

    test "deletes chosen house", %{conn: conn, house: house} do
      conn = delete conn, Routes.house_path(conn, :delete, house)
      assert redirected_to(conn) == Routes.house_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, Routes.house_path(conn, :show, house)
      end
    end
  end

  defp create_house(_) do
    house = fixture(:house)
    {:ok, house: house}
  end
end
