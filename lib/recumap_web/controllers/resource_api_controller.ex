defmodule RecumapWeb.ResourceApiController do
  use RecumapWeb, :controller

  alias Recumap.Resources

  def index(conn, params) do
    case Resources.paginate_resources(params) do
      {:ok, resources} ->
        render(conn, "index.json", resources: resources)
      _ ->
        render_status(conn, 500)
      end
  end
end
