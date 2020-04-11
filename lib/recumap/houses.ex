defmodule Recumap.Houses do
  @moduledoc """
  The Houses context.
  """

  import Ecto.Query, warn: false
  alias Recumap.Repo
import Torch.Helpers, only: [sort: 1, paginate: 4]
import Filtrex.Type.Config

alias Recumap.Houses.House

@pagination [page_size: 15]
@pagination_distance 5

@doc """
Paginate the list of houses using filtrex
filters.

## Examples

    iex> list_houses(%{})
    %{houses: [%House{}], ...}
"""
@spec paginate_houses(map) :: {:ok, map} | {:error, any}
def paginate_houses(params \\ %{}) do
  params =
    params
    |> Map.put_new("sort_direction", "desc")
    |> Map.put_new("sort_field", "inserted_at")

  {:ok, sort_direction} = Map.fetch(params, "sort_direction")
  {:ok, sort_field} = Map.fetch(params, "sort_field")

  with {:ok, filter} <- Filtrex.parse_params(filter_config(:houses), params["house"] || %{}),
       %Scrivener.Page{} = page <- do_paginate_houses(filter, params) do
    {:ok,
      %{
        houses: page.entries,
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

defp do_paginate_houses(filter, params) do
  House
  |> Filtrex.query(filter)
  |> order_by(^sort(params))
  |> paginate(Repo, params, @pagination)
end

@doc """
Returns the list of houses.

## Examples

    iex> list_houses()
    [%House{}, ...]

"""
def list_houses do
  Repo.all(House)
end

@doc """
Gets a single house.

Raises `Ecto.NoResultsError` if the House does not exist.

## Examples

    iex> get_house!(123)
    %House{}

    iex> get_house!(456)
    ** (Ecto.NoResultsError)

"""
def get_house!(id), do: Repo.get!(House, id)

@doc """
Creates a house.

## Examples

    iex> create_house(%{field: value})
    {:ok, %House{}}

    iex> create_house(%{field: bad_value})
    {:error, %Ecto.Changeset{}}

"""
def create_house(attrs \\ %{}) do
  %House{}
  |> House.changeset(attrs)
  |> Repo.insert()
end

@doc """
Updates a house.

## Examples

    iex> update_house(house, %{field: new_value})
    {:ok, %House{}}

    iex> update_house(house, %{field: bad_value})
    {:error, %Ecto.Changeset{}}

"""
def update_house(%House{} = house, attrs) do
  house
  |> House.changeset(attrs)
  |> Repo.update()
end

@doc """
Deletes a House.

## Examples

    iex> delete_house(house)
    {:ok, %House{}}

    iex> delete_house(house)
    {:error, %Ecto.Changeset{}}

"""
def delete_house(%House{} = house) do
  Repo.delete(house)
end

@doc """
Returns an `%Ecto.Changeset{}` for tracking house changes.

## Examples

    iex> change_house(house)
    %Ecto.Changeset{source: %House{}}

"""
def change_house(%House{} = house) do
  House.changeset(house, %{})
end

defp filter_config(:houses) do
  defconfig do
    text :responsible_name
      text :responsible_surname
      text :responsible_dni
      text :responsible_phone
      text :address_street
      number :address_number
      text :address_between_streets
      text :address_neighborhood
      text :address_locality
      text :demographics
      number :number_of_members
      number :number_of_minor_members
      number :number_of_older_members
      boolean :healh_issues
      boolean :earnings_formal_economy
      boolean :earnings_affected_isolation
      boolean :benefited_by_social_plan
      boolean :family_emergency_plan
      boolean :food_help
      boolean :attends_community_dining_room
      number :org_id
  end
end
end
