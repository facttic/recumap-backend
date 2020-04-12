defmodule RecumapWeb.Router do
  use RecumapWeb, :router
  use Pow.Phoenix.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    # plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :protected do
    plug Pow.Plug.RequireAuthenticated, error_handler: Pow.Phoenix.PlugErrorHandler
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug CORSPlug, origin: "*"
    plug RecumapWeb.APIAuthPlug, otp_app: :recumap
  end

  pipeline :api_protected do
    plug Pow.Plug.RequireAuthenticated, error_handler: RecumapWeb.APIAuthErrorHandler
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
    resources "/houses", HouseController
  end

  scope "/api", RecumapWeb.API do
    pipe_through :api

    resources "/registration", RegistrationController, singleton: true, only: [:create]
    resources "/session", SessionController, singleton: true, only: [:create, :delete]
    post "/session/renew", SessionController, :renew
    options "/session", SessionController, :options
    resources "/orgs", OrgApiController
    options "/orgs", OrgApiController, :options
    options "/orgs/:id", OrgApiController, :options
    resources "/resources", ResourceApiController
    options "/resources", ResourceApiController, :options
    options "/resources/:id", ResourceApiController, :options
  end

  scope "/api", RecumapWeb.API do
    pipe_through [:api, :api_protected]

    resources "/houses", HouseApiController
    options "/houses", HouseApiController, :options
    options "/houses/:id", HouseApiController, :options
  end
end
