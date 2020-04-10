defmodule Recumap.OrgsTest do
  use Recumap.DataCase

  alias Recumap.Orgs

  describe "orgs" do
    alias Recumap.Orgs.Org

    @valid_attrs %{address: "some address", demographics: "some demographics", description: "some description", name: "some name", public: true}
    @update_attrs %{address: "some updated address", demographics: "some updated demographics", description: "some updated description", name: "some updated name", public: false}
    @invalid_attrs %{address: nil, demographics: nil, description: nil, name: nil, public: nil}

    def org_fixture(attrs \\ %{}) do
      {:ok, org} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Orgs.create_org()

      org
    end

    test "paginate_orgs/1 returns paginated list of orgs" do
      for _ <- 1..20 do
        org_fixture()
      end

      {:ok, %{orgs: orgs} = page} = Orgs.paginate_orgs(%{})

      assert length(orgs) == 15
      assert page.page_number == 1
      assert page.page_size == 15
      assert page.total_pages == 2
      assert page.total_entries == 20
      assert page.distance == 5
      assert page.sort_field == "inserted_at"
      assert page.sort_direction == "desc"
    end

    test "list_orgs/0 returns all orgs" do
      org = org_fixture()
      assert Orgs.list_orgs() == [org]
    end

    test "get_org!/1 returns the org with given id" do
      org = org_fixture()
      assert Orgs.get_org!(org.id) == org
    end

    test "create_org/1 with valid data creates a org" do
      assert {:ok, %Org{} = org} = Orgs.create_org(@valid_attrs)
      assert org.address == "some address"
      assert org.demographics == "some demographics"
      assert org.description == "some description"
      assert org.name == "some name"
      assert org.public == true
    end

    test "create_org/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Orgs.create_org(@invalid_attrs)
    end

    test "update_org/2 with valid data updates the org" do
      org = org_fixture()
      assert {:ok, org} = Orgs.update_org(org, @update_attrs)
      assert %Org{} = org
      assert org.address == "some updated address"
      assert org.demographics == "some updated demographics"
      assert org.description == "some updated description"
      assert org.name == "some updated name"
      assert org.public == false
    end

    test "update_org/2 with invalid data returns error changeset" do
      org = org_fixture()
      assert {:error, %Ecto.Changeset{}} = Orgs.update_org(org, @invalid_attrs)
      assert org == Orgs.get_org!(org.id)
    end

    test "delete_org/1 deletes the org" do
      org = org_fixture()
      assert {:ok, %Org{}} = Orgs.delete_org(org)
      assert_raise Ecto.NoResultsError, fn -> Orgs.get_org!(org.id) end
    end

    test "change_org/1 returns a org changeset" do
      org = org_fixture()
      assert %Ecto.Changeset{} = Orgs.change_org(org)
    end
  end
end
