defmodule Discuss.Plugs.RequireAuth do
    import Plug.Conn
    import Phoenix.Controller
  
    alias Discuss.Router.Helpers
  
    def init(_params) do # todo a setup
      # here we can put a big computation, is like our constructor in POO,
      # it is going to be run only one time, and passed the returned value to call
    end
  
    # is to get our current_user like in rails
    def call(conn, _params) do # params argument is the value returned by the init function
      if conn.assigns[:user] do
        conn
      else
        conn
        |> put_flash(:error, "You must be logged in.")
        |> redirect(to: Helpers.topic_path(conn, :index))
        |> halt() # to indicate nothing else is happening, like we are finishing we dont need to pass to another plug, go direct to user, we are done
      end
    end
  end