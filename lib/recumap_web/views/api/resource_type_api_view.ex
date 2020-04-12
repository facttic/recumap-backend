defmodule RecumapWeb.API.ResourceTypeApiView do
  use RecumapWeb, :view
  alias RecumapWeb.API.ResourceTypeApiView

  def render("index.json", %{resource_types: resource_types}) do
    %{data: render_many(resource_types, ResourceTypeApiView, "resource_type.json")}
  end

  def render("show.json", %{resource_type: resource_type}) do
    %{data: render_one(resource_type, ResourceTypeApiView, "resource_type.json")}
  end

  def render("resource_type.json", %{resource_type_api: resource_type}) do
    %{id: resource_type.id, name: resource_type.name, details: resource_type.description}
  end
end
