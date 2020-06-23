defmodule DiscussWeb.Router do
  use DiscussWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Discuss.Plugs.SetUser # calling our new plug defined
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", DiscussWeb do # scopes works like rails
    pipe_through :browser # this line says, before go to the controller action
    # first need to proccess all inside of line 4

    get "/", PageController, :index
    #get "/topics/new", TopicController, :new
    #post "/topics", TopicController, :create
    #get "/topics", TopicController, :index
    #get "/topics/:id/edit", TopicController, :edit
    #put "/topics/:id/", TopicController, :update
    #delete "/topics/:id", TopicController, :edit
    resources "/topics", TopicController # resources as rails
  end

  scope "/auth", DiscussWeb do
    pipe_through :browser

    get "/signout", AuthController, :signout
    get "/:provider", AuthController, :request # this request is not defined by us is defined by plug Ueberauth in auth_controller.ex line 3
    get "/:provider/callback", AuthController, :callback
  end


  # Other scopes may use custom stacks.
  # scope "/api", DiscussWeb do
  #   pipe_through :api
  # end

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
      live_dashboard "/dashboard", metrics: DiscussWeb.Telemetry
    end
  end
end
