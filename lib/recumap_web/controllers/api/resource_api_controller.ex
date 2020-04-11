defmodule RecumapWeb.API.ResourceApiController do
  use RecumapWeb, :controller

  alias Recumap.Resources
  alias Recumap.Resources.Resource

  action_fallback RecumapWeb.FallbackController

  def index(conn, params) do
    case Resources.paginate_resources(params) do
      {:ok, assigns} ->
        conn
        |> put_resp_header("X-Total-Count", Integer.to_string(assigns.total_entries))
        |> render("index.json", resources: assigns.resources)
      _ ->
        render_status(conn, 500)
      end
  end

  def create(conn, %{"resource" => resource_params}) do
    with {:ok, %Resource{} = resource} <- Resources.create_resource(resource_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.resource_path(conn, :show, resource))
      |> render("show.json", resource: resource)
    end
  end

  def show(conn, %{"id" => id}) do
    resource = Resources.get_resource!(id)
    render(conn, "show.json", resource: resource)
  end

  def update(conn, %{"id" => id, "resource" => resource_params}) do
    resource = Resources.get_resource!(id)

    with {:ok, %Resource{} = resource} <- Resources.update_resource(resource, resource_params) do
      render(conn, "show.json", resource: resource)
    end
  end

  def delete(conn, %{"id" => id}) do
    resource = Resources.get_resource!(id)

    with {:ok, %Resource{}} <- Resources.delete_resource(resource) do
      send_resp(conn, :no_content, "")
    end
  end
end
