defmodule Recumap.Orgs do
  @moduledoc """
  The Orgs context.
  """

  import Ecto.Query, warn: false
  alias Recumap.Repo
import Torch.Helpers, only: [sort: 1, paginate: 4]
import Filtrex.Type.Config

alias Recumap.Orgs.Org
alias Recumap.Accounts.User

@pagination [page_size: 15]
@pagination_distance 5

@doc """
Paginate the list of orgs using filtrex
filters.

## Examples

    iex> list_orgs(%{})
    %{orgs: [%Org{}], ...}
"""
@spec paginate_orgs(map) :: {:ok, map} | {:error, any}
def paginate_orgs(params \\ %{}) do
  params =
    params
    |> Map.put_new("sort_direction", "desc")
    |> Map.put_new("sort_field", "inserted_at")

  {:ok, sort_direction} = Map.fetch(params, "sort_direction")
  {:ok, sort_field} = Map.fetch(params, "sort_field")

  with {:ok, filter} <- Filtrex.parse_params(filter_config(:orgs), params["org"] || %{}),
       %Scrivener.Page{} = page <- do_paginate_orgs(filter, params) do
    {:ok,
      %{
        orgs: page.entries,
        page_number: page.page_number,
        page_size: page.page_size,
        total_pages: page.total_pages,
        total_entries: page.total_entries,
        distance: @pagination_distance,
        sort_field: sort_field,
        sort_direction: sort_direction
      }
    }
  else
    {:error, error} -> {:error, error}
    error -> {:error, error}
  end
end

defp do_paginate_orgs(filter, params) do
  Org
  |> Filtrex.query(filter)
  |> order_by(^sort(params))
  |> paginate(Repo, params, @pagination)
end

@doc """
Returns the list of orgs.

## Examples

    iex> list_orgs()
    [%Org{}, ...]

"""
def list_orgs do
  Repo.all(Org)
end

@doc """
Gets a single org.

Raises `Ecto.NoResultsError` if the Org does not exist.

## Examples

    iex> get_org!(123)
    %Org{}

    iex> get_org!(456)
    ** (Ecto.NoResultsError)

"""
def get_org!(id), do: Repo.get!(Org, id)

@doc """
Creates a org.

## Examples

    iex> create_org(%{field: value})
    {:ok, %Org{}}

    iex> create_org(%{field: bad_value})
    {:error, %Ecto.Changeset{}}

"""
def create_org(%User{} = user, attrs \\ %{}) do
  user
  |> Ecto.build_assoc(:orgs)
  |> Org.changeset(attrs)
  |> Repo.insert()
end

@doc """
Updates a org.

## Examples

    iex> update_org(org, %{field: new_value})
    {:ok, %Org{}}

    iex> update_org(org, %{field: bad_value})
    {:error, %Ecto.Changeset{}}

"""
def update_org(%Org{} = org, attrs) do
  org
  |> Org.changeset(attrs)
  |> Repo.update()
end

@doc """
Deletes a Org.

## Examples

    iex> delete_org(org)
    {:ok, %Org{}}

    iex> delete_org(org)
    {:error, %Ecto.Changeset{}}

"""
def delete_org(%Org{} = org) do
  Repo.delete(org)
end

@doc """
Returns an `%Ecto.Changeset{}` for tracking org changes.

## Examples

    iex> change_org(org)
    %Ecto.Changeset{source: %Org{}}

"""
def change_org(%Org{} = org) do
  Org.changeset(org, %{})
end

defp filter_config(:orgs) do
  defconfig do
    text :name
      text :description
      text :address
      number :lat
      number :long
      boolean :public
      number :user_id
  end
end
end
