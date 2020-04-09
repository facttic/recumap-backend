defmodule Recumap.ResourcesTest do
  use Recumap.DataCase

  alias Recumap.Resources

  describe "resource_types" do
    alias Recumap.Resources.ResourceType

    @valid_attrs %{description: "some description", name: "some name"}
    @update_attrs %{description: "some updated description", name: "some updated name"}
    @invalid_attrs %{description: nil, name: nil}

    def resource_type_fixture(attrs \\ %{}) do
      {:ok, resource_type} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Resources.create_resource_type()

      resource_type
    end

    test "paginate_resource_types/1 returns paginated list of resource_types" do
      for _ <- 1..20 do
        resource_type_fixture()
      end

      {:ok, %{resource_types: resource_types} = page} = Resources.paginate_resource_types(%{})

      assert length(resource_types) == 15
      assert page.page_number == 1
      assert page.page_size == 15
      assert page.total_pages == 2
      assert page.total_entries == 20
      assert page.distance == 5
      assert page.sort_field == "inserted_at"
      assert page.sort_direction == "desc"
    end

    test "list_resource_types/0 returns all resource_types" do
      resource_type = resource_type_fixture()
      assert Resources.list_resource_types() == [resource_type]
    end

    test "get_resource_type!/1 returns the resource_type with given id" do
      resource_type = resource_type_fixture()
      assert Resources.get_resource_type!(resource_type.id) == resource_type
    end

    test "create_resource_type/1 with valid data creates a resource_type" do
      assert {:ok, %ResourceType{} = resource_type} = Resources.create_resource_type(@valid_attrs)
      assert resource_type.description == "some description"
      assert resource_type.name == "some name"
    end

    test "create_resource_type/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Resources.create_resource_type(@invalid_attrs)
    end

    test "update_resource_type/2 with valid data updates the resource_type" do
      resource_type = resource_type_fixture()
      assert {:ok, resource_type} = Resources.update_resource_type(resource_type, @update_attrs)
      assert %ResourceType{} = resource_type
      assert resource_type.description == "some updated description"
      assert resource_type.name == "some updated name"
    end

    test "update_resource_type/2 with invalid data returns error changeset" do
      resource_type = resource_type_fixture()
      assert {:error, %Ecto.Changeset{}} = Resources.update_resource_type(resource_type, @invalid_attrs)
      assert resource_type == Resources.get_resource_type!(resource_type.id)
    end

    test "delete_resource_type/1 deletes the resource_type" do
      resource_type = resource_type_fixture()
      assert {:ok, %ResourceType{}} = Resources.delete_resource_type(resource_type)
      assert_raise Ecto.NoResultsError, fn -> Resources.get_resource_type!(resource_type.id) end
    end

    test "change_resource_type/1 returns a resource_type changeset" do
      resource_type = resource_type_fixture()
      assert %Ecto.Changeset{} = Resources.change_resource_type(resource_type)
    end
  end

  describe "resources" do
    alias Recumap.Resources.Resource

    @valid_attrs %{demographics: "some demographics", details: "some details", name: "some name"}
    @update_attrs %{demographics: "some updated demographics", details: "some updated details", name: "some updated name"}
    @invalid_attrs %{demographics: nil, details: nil, name: nil}

    def resource_fixture(attrs \\ %{}) do
      {:ok, resource} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Resources.create_resource()

      resource
    end

    test "paginate_resources/1 returns paginated list of resources" do
      for _ <- 1..20 do
        resource_fixture()
      end

      {:ok, %{resources: resources} = page} = Resources.paginate_resources(%{})

      assert length(resources) == 15
      assert page.page_number == 1
      assert page.page_size == 15
      assert page.total_pages == 2
      assert page.total_entries == 20
      assert page.distance == 5
      assert page.sort_field == "inserted_at"
      assert page.sort_direction == "desc"
    end

    test "list_resources/0 returns all resources" do
      resource = resource_fixture()
      assert Resources.list_resources() == [resource]
    end

    test "get_resource!/1 returns the resource with given id" do
      resource = resource_fixture()
      assert Resources.get_resource!(resource.id) == resource
    end

    test "create_resource/1 with valid data creates a resource" do
      assert {:ok, %Resource{} = resource} = Resources.create_resource(@valid_attrs)
      assert resource.demographics == "some demographics"
      assert resource.details == "some details"
      assert resource.name == "some name"
    end

    test "create_resource/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Resources.create_resource(@invalid_attrs)
    end

    test "update_resource/2 with valid data updates the resource" do
      resource = resource_fixture()
      assert {:ok, resource} = Resources.update_resource(resource, @update_attrs)
      assert %Resource{} = resource
      assert resource.demographics == "some updated demographics"
      assert resource.details == "some updated details"
      assert resource.name == "some updated name"
    end

    test "update_resource/2 with invalid data returns error changeset" do
      resource = resource_fixture()
      assert {:error, %Ecto.Changeset{}} = Resources.update_resource(resource, @invalid_attrs)
      assert resource == Resources.get_resource!(resource.id)
    end

    test "delete_resource/1 deletes the resource" do
      resource = resource_fixture()
      assert {:ok, %Resource{}} = Resources.delete_resource(resource)
      assert_raise Ecto.NoResultsError, fn -> Resources.get_resource!(resource.id) end
    end

    test "change_resource/1 returns a resource changeset" do
      resource = resource_fixture()
      assert %Ecto.Changeset{} = Resources.change_resource(resource)
    end
  end
end
