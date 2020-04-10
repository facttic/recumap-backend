
defmodule RecumapWeb.ResourceApiView do
  use RecumapWeb, :view

  def render("index.json", %{resources: resources}) do
    %{data: resources}
  end
end
