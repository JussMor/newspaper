defmodule NewspaperWeb.Router do
  use NewspaperWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {NewspaperWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", NewspaperWeb do
    pipe_through :browser

    get "/", PageController, :home
    get "/players", PlayersController, :player
    live "/stadiums", StadiumLive.Index, :index
    live "/stadiums/new", StadiumLive.Index, :new
    live "/stadiums/:id/edit", StadiumLive.Index, :edit
    live "/stadiums/:id", StadiumLive.Show, :show
    live "/stadiums/:id/show/edit", StadiumLive.Show, :edit
  end

  # Other scopes may use custom stacks.
  scope "/api", NewspaperWeb do
    pipe_through :api
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:newspaper, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: NewspaperWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end