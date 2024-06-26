defmodule NewspaperWeb.Router do
  use NewspaperWeb, :router

  import NewspaperWeb.UserAuth
  import NewspaperWeb.Sidebar

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {NewspaperWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user

  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", NewspaperWeb do
    pipe_through :browser

    get "/", PageController, :home
    get "/champions", ChampionController, :index
    get "/champions/new",  ChampionController, :new
    get "/champions/:id", ChampionController, :show
    post "/champions", ChampionController, :create
    put "/champions/:id", ChampionController, :update
    get "/champions/:id/edit", ChampionController, :edit
    delete "/champions/:id", ChampionController, :delete

    get "/players", PlayersController, :player

    live "/stadiums", StadiumLive.Index, :index
    live "/stadiums/new", StadiumLive.Index, :new
    live "/stadiums/:id/edit", StadiumLive.Index, :edit
    live "/stadiums/:id", StadiumLive.Show, :show
    live "/stadiums/:id/show/edit", StadiumLive.Show, :edit

    live "/lasnews", LastNewLive.Index, :index
    live "/lasnews/new", LastNewLive.Index, :new
    live "/lasnews/:id/edit", LastNewLive.Index, :edit
    live "/lasnews/:id", LastNewLive.Show, :show
    live "/lasnews/:id/show/edit", LastNewLive.Show, :edit

    live "/ultimas-noticias", LastNewPublicLive.Index, :index


    live "/articles", ArticleLive.Index, :index
    live "/articles/new", ArticleLive.Index, :new
    live "/articles/:id/edit", ArticleLive.Index, :edit

    live "/articles/:id", ArticleLive.Show, :show
    live "/articles/:id/show/edit", ArticleLive.Show, :edit

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

  ## Authentication routes

  scope "/", NewspaperWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    live_session :redirect_if_user_is_authenticated,
      on_mount: [{NewspaperWeb.UserAuth, :redirect_if_user_is_authenticated}] do
      live "/users/register", UserRegistrationLive, :new
      live "/users/log_in", UserLoginLive, :new
      live "/users/reset_password", UserForgotPasswordLive, :new
      live "/users/reset_password/:token", UserResetPasswordLive, :edit
    end

    post "/users/log_in", UserSessionController, :create
  end

  scope "/", NewspaperWeb do
    pipe_through [:browser, :require_authenticated_user]

    live_session :require_authenticated_user,
      on_mount: [{NewspaperWeb.UserAuth, :ensure_authenticated},{NewspaperWeb.Sidebar, :mount_sidebar}] do
      live "/authrouter", AppLive.Index, :index

      live "/settings/roles", RolesLive.Index, :index
      live "/settings/roles/new", RolesLive.Index, :new
      live "/settings/roles/:id/edit", RolesLive.Index, :edit

      live "/security/permissions", PermissionsLive.Index, :index
      live "/security/permissions/new", PermissionsLive.Index, :new
      live "/security/permissions/:id/edit", PermissionsLive.Index, :edit


      live "/users", UsersLive.Index, :index
      live "/role_permission", RolePermissionLive.Index, :index


      live "/users/settings", UserSettingsLive, :edit
      live "/users/settings/confirm_email/:token", UserSettingsLive, :confirm_email
    end
  end

  scope "/", NewspaperWeb do
    pipe_through [:browser]

    delete "/users/log_out", UserSessionController, :delete

    live_session :current_user,
      on_mount: [{NewspaperWeb.UserAuth, :mount_current_user}] do
      live "/users/confirm/:token", UserConfirmationLive, :edit
      live "/users/confirm", UserConfirmationInstructionsLive, :new
    end
  end
end
