defmodule RecumapWeb.API.OrgApiController do
  use RecumapWeb, :controller

  alias Recumap.Orgs
  alias Recumap.Orgs.Org

  action_fallback RecumapWeb.FallbackController

  @spec index(Plug.Conn.t(), map) :: Plug.Conn.t()
  def index(conn, params) do
    config = Pow.Plug.fetch_config(conn)
    paginate_params =
      case Pow.Plug.current_user(conn, config) do
        nil ->
          case Map.get(params, "org") do
            nil -> %{"org" => %{"public" => true}}
            %{} ->
              put_in(params, ["org", "public"], true)
          end
      _ ->
        params
      end      
      
      case Orgs.paginate_orgs(paginate_params) do
        {:ok, assigns} ->
          render(conn, "index.json", orgs: assigns.orgs)
        _ ->
          render_status(conn, 500)
      end
  end

  def create(conn, %{"org" => org_params}) do
    with {:ok, %Org{} = org} <- Orgs.create_org(org_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.org_path(conn, :show, org))
      |> render("show.json", org: org)
    end
  end

  def show(conn, %{"id" => id}) do
    org = Orgs.get_org!(id)
    render(conn, "show.json", org: org)
  end

  def update(conn, %{"id" => id, "org" => org_params}) do
    org = Orgs.get_org!(id)

    with {:ok, %Org{} = org} <- Orgs.update_org(org, org_params) do
      render(conn, "show.json", org: org)
    end
  end

  def delete(conn, %{"id" => id}) do
    org = Orgs.get_org!(id)

    with {:ok, %Org{}} <- Orgs.delete_org(org) do
      send_resp(conn, :no_content, "")
    end
  end
end
