defmodule RecumapWeb.API.RegistrationController do
  use RecumapWeb, :controller

  alias Ecto.Changeset
  alias Plug.Conn
  alias RecumapWeb.ErrorHelpers
  
  alias Recumap.Orgs
  alias Recumap.Orgs.Org

  @spec create(Conn.t(), map()) :: Conn.t()
  def create(conn, %{"user" => user_params, "org" => org_params}) do
    conn
    |> Pow.Plug.create_user(user_params)
    |> case do
      {:ok, _user, conn} ->
        case Orgs.create_org(_user, org_params) do
          {:ok, %Org{} = org} ->
            json(conn, %{data: %{token: conn.private[:api_access_token], renewal_token: conn.private[:api_renewal_token]}})
          {:error, %Ecto.Changeset{} = changeset} ->
            errors = Changeset.traverse_errors(changeset, &ErrorHelpers.translate_error/1)
    
            conn
            |> put_status(500)
            |> json(%{error: %{status: 500, message: "Couldn't create org", errors: errors}})
        end
      {:error, changeset, conn} ->
        errors = Changeset.traverse_errors(changeset, &ErrorHelpers.translate_error/1)

        conn
        |> put_status(500)
        |> json(%{error: %{status: 500, message: "Couldn't create user", errors: errors}})
      end
  end
end
