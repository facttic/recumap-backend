defmodule RecumapWeb.Router do
  use RecumapWeb, :router
  use Pow.Phoenix.Router

  pipeline :protected do
    plug Pow.Plug.RequireAuthenticated,
      error_handler: Pow.Phoenix.PlugErrorHandler
  end

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through :browser

    pow_routes()
  end

  scope "/", RecumapWeb do
    pipe_through [:browser, :protected]

    get "/", UserController, :index

    resources "/users", UserController
    resources "/resource_types", ResourceTypeController
    resources "/resources", ResourceController
    resources "/orgs", OrgController
  end

  scope "/api", RecumapWeb do
    pipe_through :api

    get "/resources", ResourceApiController, :index
    resources "/orgs", OrgApiController
  end
end
