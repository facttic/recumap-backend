defmodule RecumapWeb.ResourceTypeControllerTest do
  use RecumapWeb.ConnCase

  alias Recumap.Resources

  @create_attrs %{description: "some description", name: "some name"}
  @update_attrs %{description: "some updated description", name: "some updated name"}
  @invalid_attrs %{description: nil, name: nil}

  def fixture(:resource_type) do
    {:ok, resource_type} = Resources.create_resource_type(@create_attrs)
    resource_type
  end

  describe "index" do
    test "lists all resource_types", %{conn: conn} do
      conn = get conn, Routes.resource_type_path(conn, :index)
      assert html_response(conn, 200) =~ "Resource types"
    end
  end

  describe "new resource_type" do
    test "renders form", %{conn: conn} do
      conn = get conn, Routes.resource_type_path(conn, :new)
      assert html_response(conn, 200) =~ "New Resource type"
    end
  end

  describe "create resource_type" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, Routes.resource_type_path(conn, :create), resource_type: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.resource_type_path(conn, :show, id)

      conn = get conn, Routes.resource_type_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Resource type Details"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, Routes.resource_type_path(conn, :create), resource_type: @invalid_attrs
      assert html_response(conn, 200) =~ "New Resource type"
    end
  end

  describe "edit resource_type" do
    setup [:create_resource_type]

    test "renders form for editing chosen resource_type", %{conn: conn, resource_type: resource_type} do
      conn = get conn, Routes.resource_type_path(conn, :edit, resource_type)
      assert html_response(conn, 200) =~ "Edit Resource type"
    end
  end

  describe "update resource_type" do
    setup [:create_resource_type]

    test "redirects when data is valid", %{conn: conn, resource_type: resource_type} do
      conn = put conn, Routes.resource_type_path(conn, :update, resource_type), resource_type: @update_attrs
      assert redirected_to(conn) == Routes.resource_type_path(conn, :show, resource_type)

      conn = get conn, Routes.resource_type_path(conn, :show, resource_type)
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, resource_type: resource_type} do
      conn = put conn, Routes.resource_type_path(conn, :update, resource_type), resource_type: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Resource type"
    end
  end

  describe "delete resource_type" do
    setup [:create_resource_type]

    test "deletes chosen resource_type", %{conn: conn, resource_type: resource_type} do
      conn = delete conn, Routes.resource_type_path(conn, :delete, resource_type)
      assert redirected_to(conn) == Routes.resource_type_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, Routes.resource_type_path(conn, :show, resource_type)
      end
    end
  end

  defp create_resource_type(_) do
    resource_type = fixture(:resource_type)
    {:ok, resource_type: resource_type}
  end
end
