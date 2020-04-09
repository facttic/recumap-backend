defmodule RecumapWeb.Router do
  use RecumapWeb, :router

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

  scope "/", RecumapWeb do
    pipe_through :browser

    get "/", UserController, :index

    resources "/users", UserController
    resources "/resource_types", ResourceTypeController
    resources "/resources", ResourceController
  end

  # Other scopes may use custom stacks.
  # scope "/api", RecumapWeb do
  #   pipe_through :api
  # end
end
