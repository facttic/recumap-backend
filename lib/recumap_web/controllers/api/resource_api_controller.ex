defmodule RecumapWeb.ResourceApiController do
  use RecumapWeb, :controller

  alias Recumap.Resources

  action_fallback RecumapWeb.FallbackController

  def index(conn, params) do
    case Resources.paginate_resources(params) do
      {:ok, assigns} ->
        render(conn, "index.json", resources: assigns.resources)
      _ ->
        render_status(conn, 500)
      end
  end
end
