defmodule Discuss.Plugs.SetUser do
  import Plug.Conn
  import Phoenix.Controller

  alias Discuss.Repo
  alias Discuss.User

  def init(_params) do # todo a setup
    # here we can put a big computation, is like our constructor in POO,
    # it is going to be run only one time, and passed the returned value to call
  end

  # is to get our current_user like in rails
  def call(conn, _params) do # params argument is the value returned by the init function
    user_id = get_session(conn, :user_id)

    cond do # is like a lot of elsif or case in ruby
      user = user_id && Repo.get(User, user_id) ->
        assign(conn, :user, user)
        # conn.assings.user => user struct
      true ->
        assign(conn, :user, nil)
    end
  end
end