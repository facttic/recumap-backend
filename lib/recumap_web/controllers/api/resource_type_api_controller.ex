defmodule RecumapWeb.API.ResourceTypeApiController do
  use RecumapWeb, :controller

  alias Recumap.Resources
  alias Recumap.Resources.ResourceType

  action_fallback RecumapWeb.FallbackController

  def index(conn, params) do
    config = Pow.Plug.fetch_config(conn)

    paginate_params =
      case Pow.Plug.current_user(conn, config) do
        nil ->
          params

        user ->
          case Map.get(params, "resource_type") do
            nil ->
              %{"resource_type" => %{"user_id" => user.id}}

            %{} ->
              put_in(params, ["resource_type", "user_id"], user.id)
          end
      end

    case Resources.paginate_resource_types(paginate_params) do
      {:ok, assigns} ->
        conn
        |> render("index.json", resource_types: assigns.resource_types)

      _ ->
        render_status(conn, 500)
    end
  end

  def create(conn, %{"resource_type" => resource_type_params}) do
    user = Pow.Plug.current_user(conn)

    with {:ok, %ResourceType{} = resource_type} <-
           Resources.create_resource_type(user, resource_type_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.resource_type_path(conn, :show, resource_type))
      |> render("show.json", resource_type: resource_type)
    end
  end

  def show(conn, %{"id" => id}) do
    resource_type = Resources.get_resource_type!(id)
    render(conn, "show.json", resource_type: resource_type)
  end

  def update(conn, %{"id" => id, "resource_type" => resource_type_params}) do
    resource_type = Resources.get_resource_type!(id)
    user = Pow.Plug.current_user(conn)

    if resource_type.user_id == user.id do
      with {:ok, %ResourceType{} = resource_type} <-
             Resources.update_resource_type(resource_type, resource_type_params) do
        render(conn, "show.json", resource_type: resource_type)
      end
    else
      conn
      |> put_status(404)
      |> json(%{error: %{code: 404, message: "Does not exist or does not belong to you"}})
    end
  end

  def delete(conn, %{"id" => id}) do
    resource_type = Resources.get_resource_type!(id)
    user = Pow.Plug.current_user(conn)

    if resource_type.user_id == user.id do
      with {:ok, %ResourceType{}} <- Resources.delete_resource_type(resource_type) do
        send_resp(conn, :no_content, "")
      end
    else
      conn
      |> put_status(404)
      |> json(%{error: %{code: 404, message: "Does not exist or does not belong to you"}})
    end
  end
end
