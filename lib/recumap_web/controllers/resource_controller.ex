defmodule RecumapWeb.ResourceController do
  use RecumapWeb, :controller

  alias Recumap.Resources
  alias Recumap.Resources.Resource
  alias Recumap.Resources.ResourceType

  plug(:put_layout, {RecumapWeb.LayoutView, "torch.html"})

  def index(conn, params) do
    case Resources.paginate_resources(params) do
      {:ok, assigns} ->
        render(conn, "index.html", assigns)
      error ->
        conn
        |> put_flash(:error, "There was an error rendering Resources. #{inspect(error)}")
        |> redirect(to: Routes.resource_path(conn, :index))
    end
  end

  def new(conn, _params) do
    changeset = Resources.change_resource(%Resource{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"resource" => resource_params}) do
    user = Pow.Plug.current_user(conn)
    resource_type = Resources.get_resource_type!(resource_params.resource_type_id)

    case Resources.create_resource(resource_type, user.id, resource_params) do
      {:ok, resource} ->
        conn
        |> put_flash(:info, "Resource created successfully.")
        |> redirect(to: Routes.resource_path(conn, :show, resource))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    resource = Resources.get_resource!(id)
    render(conn, "show.html", resource: resource)
  end

  def edit(conn, %{"id" => id}) do
    resource = Resources.get_resource!(id)
    changeset = Resources.change_resource(resource)
    render(conn, "edit.html", resource: resource, changeset: changeset)
  end

  def update(conn, %{"id" => id, "resource" => resource_params}) do
    resource = Resources.get_resource!(id)

    case Resources.update_resource(resource, resource_params) do
      {:ok, resource} ->
        conn
        |> put_flash(:info, "Resource updated successfully.")
        |> redirect(to: Routes.resource_path(conn, :show, resource))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", resource: resource, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    resource = Resources.get_resource!(id)
    {:ok, _resource} = Resources.delete_resource(resource)

    conn
    |> put_flash(:info, "Resource deleted successfully.")
    |> redirect(to: Routes.resource_path(conn, :index))
  end
end
