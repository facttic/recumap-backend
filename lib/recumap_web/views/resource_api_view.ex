
defmodule RecumapWeb.ResourceApiView do
  use RecumapWeb, :view
  alias RecumapWeb.ResourceApiView

  def render("index.json", %{resources: resources}) do
    %{data: render_many(resources, ResourceApiView, "resource.json")}
  end

  def render("resource.json", %{resource_api: resource}) do
    %{id: resource.id,
      name: resource.name,
      details: resource.details}
  end
end
