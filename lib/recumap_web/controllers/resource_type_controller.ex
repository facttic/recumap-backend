defmodule RecumapWeb.ResourceTypeController do
  use RecumapWeb, :controller

  alias Recumap.Resources
  alias Recumap.Resources.ResourceType

  plug(:put_layout, {RecumapWeb.LayoutView, "torch.html"})

  def index(conn, params) do
    config = Pow.Plug.fetch_config(conn)
    paginate_params =
      case Pow.Plug.current_user(conn, config) do
        nil ->
          params
        user ->
          case Map.get(params, "resource_type") do
            nil -> %{"resource_type" => %{"user_id" => user.id}}
            %{} ->
              put_in(params, ["resource_type", "user_id"], user.id)
          end
      end

    case Resources.paginate_resource_types(paginate_params) do
      {:ok, assigns} ->
        render(conn, "index.html", assigns)
      error ->
        conn
        |> put_flash(:error, "There was an error rendering Resource types. #{inspect(error)}")
        |> redirect(to: Routes.resource_type_path(conn, :index))
    end
  end

  def new(conn, _params) do
    changeset = Resources.change_resource_type(%ResourceType{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"resource_type" => resource_type_params}) do
    user = Pow.Plug.current_user(conn)

    case Resources.create_resource_type(user, resource_type_params) do
      {:ok, resource_type} ->
        conn
        |> put_flash(:info, "Resource type created successfully.")
        |> redirect(to: Routes.resource_type_path(conn, :show, resource_type))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    resource_type = Resources.get_resource_type!(id)
    render(conn, "show.html", resource_type: resource_type)
  end

  def edit(conn, %{"id" => id}) do
    resource_type = Resources.get_resource_type!(id)
    changeset = Resources.change_resource_type(resource_type)
    render(conn, "edit.html", resource_type: resource_type, changeset: changeset)
  end

  def update(conn, %{"id" => id, "resource_type" => resource_type_params}) do
    resource_type = Resources.get_resource_type!(id)

    case Resources.update_resource_type(resource_type, resource_type_params) do
      {:ok, resource_type} ->
        conn
        |> put_flash(:info, "Resource type updated successfully.")
        |> redirect(to: Routes.resource_type_path(conn, :show, resource_type))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", resource_type: resource_type, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    resource_type = Resources.get_resource_type!(id)
    {:ok, _resource_type} = Resources.delete_resource_type(resource_type)

    conn
    |> put_flash(:info, "Resource type deleted successfully.")
    |> redirect(to: Routes.resource_type_path(conn, :index))
  end
end
