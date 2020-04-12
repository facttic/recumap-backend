defmodule RecumapWeb.OrgController do
  use RecumapWeb, :controller

  alias Recumap.Orgs
  alias Recumap.Orgs.Org

  plug(:put_layout, {RecumapWeb.LayoutView, "torch.html"})

  @spec index(Plug.Conn.t(), map) :: Plug.Conn.t()
  def index(conn, params) do
    user = Pow.Plug.current_user(conn)
    paginate_params =
      case Map.get(params, "org") do
        nil -> %{"org" => %{"user_id" => user.id}}
        %{} ->
          put_in(params, ["org", "user_id"], user.id)
      end

    case Orgs.paginate_orgs(paginate_params) do
      {:ok, assigns} ->
        render(conn, "index.html", assigns)
      error ->
        conn
        |> put_flash(:error, "There was an error rendering Orgs. #{inspect(error)}")
        |> redirect(to: Routes.org_path(conn, :index))
    end
  end

  def new(conn, _params) do
    changeset = Orgs.change_org(%Org{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"org" => org_params}) do
    user = Pow.Plug.current_user(conn)

    case Orgs.create_org(user, org_params) do
      {:ok, org} ->
        conn
        |> put_flash(:info, "Org created successfully.")
        |> redirect(to: Routes.org_path(conn, :show, org))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    org = Orgs.get_org!(id)
    render(conn, "show.html", org: org)
  end

  def edit(conn, %{"id" => id}) do
    org = Orgs.get_org!(id)
    changeset = Orgs.change_org(org)
    render(conn, "edit.html", org: org, changeset: changeset)
  end

  def update(conn, %{"id" => id, "org" => org_params}) do
    org = Orgs.get_org!(id)

    case Orgs.update_org(org, org_params) do
      {:ok, org} ->
        conn
        |> put_flash(:info, "Org updated successfully.")
        |> redirect(to: Routes.org_path(conn, :show, org))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", org: org, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    org = Orgs.get_org!(id)
    {:ok, _org} = Orgs.delete_org(org)

    conn
    |> put_flash(:info, "Org deleted successfully.")
    |> redirect(to: Routes.org_path(conn, :index))
  end
end
