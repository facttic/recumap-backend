defmodule RecumapWeb.API.ResourceApiController do
  use RecumapWeb, :controller

  alias Recumap.Resources
  alias Recumap.Resources.Resource

  action_fallback RecumapWeb.FallbackController

  def index(conn, params) do
    config = Pow.Plug.fetch_config(conn)
    paginate_params =
      case Pow.Plug.current_user(conn, config) do
        nil ->
          params
        user ->
          case Map.get(params, "resource") do
            nil -> %{"resource" => %{"user_id" => user.id}}
            %{} ->
              put_in(params, ["resource", "user_id"], user.id)
          end
      end

    case Resources.paginate_resources(paginate_params) do
      {:ok, assigns} ->
        conn
        |> put_resp_header("X-Total-Count", Integer.to_string(assigns.total_entries))
        |> render("index.json", resources: assigns.resources)
      _ ->
        render_status(conn, 500)
      end
  end

  def create(conn, %{"resource" => resource_params}) do
    user = Pow.Plug.current_user(conn)
    resource_type = Resources.get_resource_type!(resource_params["resource_type_id"])

    with {:ok, %Resource{} = resource} <- Resources.create_resource(user, resource_type, resource_params) do
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
    user = Pow.Plug.current_user(conn)

    if resource.user_id == user.id do
      with {:ok, %Resource{} = resource} <- Resources.update_resource(resource, resource_params) do
        render(conn, "show.json", resource: resource)
      end
    else
      conn
        |> put_status(404)
        |> json(%{error: %{code: 404, message: "Does not exist or does not belong to you"}})
    end
  end

  def delete(conn, %{"id" => id}) do
    resource = Resources.get_resource!(id)
    user = Pow.Plug.current_user(conn)

    if resource.user_id == user.id do
      with {:ok, %Resource{}} <- Resources.delete_resource(resource) do
        send_resp(conn, :no_content, "")
      end
    else
      conn
        |> put_status(404)
        |> json(%{error: %{code: 404, message: "Does not exist or does not belong to you"}})
    end
  end
end
