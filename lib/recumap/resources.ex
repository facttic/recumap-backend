defmodule Recumap.Resources do
  @moduledoc """
  The Resources context.
  """

  import Ecto.Query, warn: false
  alias Recumap.Repo
import Torch.Helpers, only: [sort: 1, paginate: 4]
import Filtrex.Type.Config

alias Recumap.Resources.ResourceType

@pagination [page_size: 15]
@pagination_distance 5

@doc """
Paginate the list of resource_types using filtrex
filters.

## Examples

    iex> list_resource_types(%{})
    %{resource_types: [%ResourceType{}], ...}
"""
@spec paginate_resource_types(map) :: {:ok, map} | {:error, any}
def paginate_resource_types(params \\ %{}) do
  params =
    params
    |> Map.put_new("sort_direction", "desc")
    |> Map.put_new("sort_field", "inserted_at")

  {:ok, sort_direction} = Map.fetch(params, "sort_direction")
  {:ok, sort_field} = Map.fetch(params, "sort_field")

  with {:ok, filter} <- Filtrex.parse_params(filter_config(:resource_types), params["resource_type"] || %{}),
       %Scrivener.Page{} = page <- do_paginate_resource_types(filter, params) do
    {:ok,
      %{
        resource_types: page.entries,
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

defp do_paginate_resource_types(filter, params) do
  ResourceType
  |> Filtrex.query(filter)
  |> order_by(^sort(params))
  |> paginate(Repo, params, @pagination)
end

@doc """
Returns the list of resource_types.

## Examples

    iex> list_resource_types()
    [%ResourceType{}, ...]

"""
def list_resource_types do
  Repo.all(ResourceType)
end

@doc """
Gets a single resource_type.

Raises `Ecto.NoResultsError` if the Resource type does not exist.

## Examples

    iex> get_resource_type!(123)
    %ResourceType{}

    iex> get_resource_type!(456)
    ** (Ecto.NoResultsError)

"""
def get_resource_type!(id), do: Repo.get!(ResourceType, id)

@doc """
Creates a resource_type.

## Examples

    iex> create_resource_type(%{field: value})
    {:ok, %ResourceType{}}

    iex> create_resource_type(%{field: bad_value})
    {:error, %Ecto.Changeset{}}

"""
def create_resource_type(attrs \\ %{}) do
  %ResourceType{}
  |> ResourceType.changeset(attrs)
  |> Repo.insert()
end

@doc """
Updates a resource_type.

## Examples

    iex> update_resource_type(resource_type, %{field: new_value})
    {:ok, %ResourceType{}}

    iex> update_resource_type(resource_type, %{field: bad_value})
    {:error, %Ecto.Changeset{}}

"""
def update_resource_type(%ResourceType{} = resource_type, attrs) do
  resource_type
  |> ResourceType.changeset(attrs)
  |> Repo.update()
end

@doc """
Deletes a ResourceType.

## Examples

    iex> delete_resource_type(resource_type)
    {:ok, %ResourceType{}}

    iex> delete_resource_type(resource_type)
    {:error, %Ecto.Changeset{}}

"""
def delete_resource_type(%ResourceType{} = resource_type) do
  Repo.delete(resource_type)
end

@doc """
Returns an `%Ecto.Changeset{}` for tracking resource_type changes.

## Examples

    iex> change_resource_type(resource_type)
    %Ecto.Changeset{source: %ResourceType{}}

"""
def change_resource_type(%ResourceType{} = resource_type) do
  ResourceType.changeset(resource_type, %{})
end

defp filter_config(:resource_types) do
  defconfig do
    text :name
      text :description

  end
end
import Torch.Helpers, only: [sort: 1, paginate: 4]
import Filtrex.Type.Config

alias Recumap.Resources.Resource

@pagination [page_size: 15]
@pagination_distance 5

@doc """
Paginate the list of resources using filtrex
filters.

## Examples

    iex> list_resources(%{})
    %{resources: [%Resource{}], ...}
"""
@spec paginate_resources(map) :: {:ok, map} | {:error, any}
def paginate_resources(params \\ %{}) do
  params =
    params
    |> Map.put_new("sort_direction", "desc")
    |> Map.put_new("sort_field", "inserted_at")

  {:ok, sort_direction} = Map.fetch(params, "sort_direction")
  {:ok, sort_field} = Map.fetch(params, "sort_field")

  with {:ok, filter} <- Filtrex.parse_params(filter_config(:resources), params["resource"] || %{}),
       %Scrivener.Page{} = page <- do_paginate_resources(filter, params) do
    {:ok,
      %{
        resources: page.entries,
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

defp do_paginate_resources(filter, params) do
  Resource
  |> Filtrex.query(filter)
  |> order_by(^sort(params))
  |> paginate(Repo, params, @pagination)
end

@doc """
Returns the list of resources.

## Examples

    iex> list_resources()
    [%Resource{}, ...]

"""
def list_resources do
  Repo.all(Resource)
end

@doc """
Gets a single resource.

Raises `Ecto.NoResultsError` if the Resource does not exist.

## Examples

    iex> get_resource!(123)
    %Resource{}

    iex> get_resource!(456)
    ** (Ecto.NoResultsError)

"""
def get_resource!(id), do: Repo.get!(Resource, id)

@doc """
Creates a resource.

## Examples

    iex> create_resource(%{field: value})
    {:ok, %Resource{}}

    iex> create_resource(%{field: bad_value})
    {:error, %Ecto.Changeset{}}

"""
def create_resource(attrs \\ %{}) do
  %Resource{}
  |> Resource.changeset(attrs)
  |> Repo.insert()
end

@doc """
Updates a resource.

## Examples

    iex> update_resource(resource, %{field: new_value})
    {:ok, %Resource{}}

    iex> update_resource(resource, %{field: bad_value})
    {:error, %Ecto.Changeset{}}

"""
def update_resource(%Resource{} = resource, attrs) do
  resource
  |> Resource.changeset(attrs)
  |> Repo.update()
end

@doc """
Deletes a Resource.

## Examples

    iex> delete_resource(resource)
    {:ok, %Resource{}}

    iex> delete_resource(resource)
    {:error, %Ecto.Changeset{}}

"""
def delete_resource(%Resource{} = resource) do
  Repo.delete(resource)
end

@doc """
Returns an `%Ecto.Changeset{}` for tracking resource changes.

## Examples

    iex> change_resource(resource)
    %Ecto.Changeset{source: %Resource{}}

"""
def change_resource(%Resource{} = resource) do
  Resource.changeset(resource, %{})
end

defp filter_config(:resources) do
  defconfig do
    text :name
    text :responsible_name
    text :responsible_surname
    text :responsible_dni
    text :responsible_phone
    text :address_street
    number :address_number
    text :address_between_streets
    text :address_neighborhood
    text :address_locality
    number :lat
    number :long
    text :details
    number :user_id
  end
end
end
