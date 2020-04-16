defmodule RecumapWeb.PageController do
  use RecumapWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
