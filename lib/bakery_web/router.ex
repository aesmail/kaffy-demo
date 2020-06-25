defmodule BakeryWeb.Router do
  use BakeryWeb, :router

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

  use Kaffy.Routes

  scope "/", BakeryWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", BakeryWeb do
    pipe_through :api

    resources "/categories", CategoryController, except: [:new, :edit]
    resources "/products", ProductController, except: [:new, :edit]
    resources "/ingredients", IngredientController, except: [:new, :edit]
    resources "/tags", TagController, except: [:new, :edit]
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: BakeryWeb.Telemetry
    end
  end
end
