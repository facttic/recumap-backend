
defmodule RecumapWeb.ResourceApiView do
  use RecumapWeb, :view
  alias RecumapWeb.ResourceApiView

  def render("index.json", %{resources: resources}) do
    %{data: render_many(resources, ResourceApiView, "resource.json")}
  end

  def render("resource.json", %{resource_api: resource}) do
    %{id: resource.id,
      responsible_name: resource.responsible_name,
      responsible_surname: resource.responsible_surname,
      responsible_dni: resource.responsible_dni,
      responsible_phone: resource.responsible_phone,
      address_street: resource.address_street,
      address_number: resource.address_number,
      address_between_streets: resource.address_between_streets,
      address_neighborhood: resource.address_neighborhood,
      address_locality: resource.address_locality,
      lat: resource.lat,
      long: resource.long,
      name: resource.name,
      details: resource.details}
  end
end
