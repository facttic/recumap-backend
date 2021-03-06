defmodule RecumapWeb.API.HouseApiController do
  use RecumapWeb, :controller

  alias Recumap.Houses
  alias Recumap.Houses.House

  action_fallback RecumapWeb.FallbackController

  @spec index(Plug.Conn.t(), map) :: Plug.Conn.t()
  def index(conn, params) do
    config = Pow.Plug.fetch_config(conn)
    user = Pow.Plug.current_user(conn, config)
    paginate_params =
      case Map.get(params, "house") do
        nil -> %{"house" => %{"user_id" => user.id}}
        %{} ->
          put_in(params, ["house", "user_id"], user.id)
      end

    case Houses.paginate_houses(paginate_params) do
      {:ok, assigns} ->
        conn
        |> put_resp_header("X-Total-Count", Integer.to_string(assigns.total_entries))
        |> render("index.json", houses: assigns.houses)
      _ ->
        render_status(conn, 500)
      end
  end

  def create(conn, %{"house" => house_params}) do
    user = Pow.Plug.current_user(conn)

    with {:ok, %House{} = house} <- Houses.create_house(user, house_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.house_path(conn, :show, house))
      |> render("show.json", house: house)
    end
  end

  def show(conn, %{"id" => id}) do
    house = Houses.get_house!(id)
    render(conn, "show.json", house: house)
  end

  def update(conn, %{"id" => id, "house" => house_params}) do
    user = Pow.Plug.current_user(conn)
    house = Houses.get_house!(id)

    if house.user_id == user.id do
      with {:ok, %House{} = house} <- Houses.update_house(house, house_params) do
        render(conn, "show.json", house: house)
      end
    else
      conn
        |> put_status(404)
        |> json(%{error: %{code: 404, message: "Does not exist or does not belong to you"}})
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Pow.Plug.current_user(conn)
    house = Houses.get_house!(id)

    if house.user_id == user.id do
      with {:ok, %House{}} <- Houses.delete_house(house) do
        send_resp(conn, :no_content, "")
      end
    else
      conn
        |> put_status(404)
        |> json(%{error: %{code: 404, message: "Does not exist or does not belong to you"}})
    end
    
  end
end
