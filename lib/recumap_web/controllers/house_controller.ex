defmodule RecumapWeb.HouseController do
  use RecumapWeb, :controller

  alias Recumap.Houses
  alias Recumap.Houses.House

  plug(:put_layout, {RecumapWeb.LayoutView, "torch.html"})

  def index(conn, params) do
    user = Pow.Plug.current_user(conn)
    paginate_params =
      case Map.get(params, "house") do
        nil -> %{"house" => %{"user_id" => user.id}}
        %{} ->
          put_in(params, ["house", "user_id"], user.id)
      end

    case Houses.paginate_houses(paginate_params) do
      {:ok, assigns} ->
        render(conn, "index.html", assigns)
      error ->
        conn
        |> put_flash(:error, "There was an error rendering Houses. #{inspect(error)}")
        |> redirect(to: Routes.house_path(conn, :index))
    end
  end

  def new(conn, _params) do
    changeset = Houses.change_house(%House{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"house" => house_params}) do
    user = Pow.Plug.current_user(conn)

    case Houses.create_house(user, house_params) do
      {:ok, house} ->
        conn
        |> put_flash(:info, "House created successfully.")
        |> redirect(to: Routes.house_path(conn, :show, house))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    house = Houses.get_house!(id)
    render(conn, "show.html", house: house)
  end

  def edit(conn, %{"id" => id}) do
    house = Houses.get_house!(id)
    changeset = Houses.change_house(house)
    render(conn, "edit.html", house: house, changeset: changeset)
  end

  def update(conn, %{"id" => id, "house" => house_params}) do
    house = Houses.get_house!(id)

    case Houses.update_house(house, house_params) do
      {:ok, house} ->
        conn
        |> put_flash(:info, "House updated successfully.")
        |> redirect(to: Routes.house_path(conn, :show, house))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", house: house, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    house = Houses.get_house!(id)
    {:ok, _house} = Houses.delete_house(house)

    conn
    |> put_flash(:info, "House deleted successfully.")
    |> redirect(to: Routes.house_path(conn, :index))
  end
end
