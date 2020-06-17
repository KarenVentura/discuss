defmodule DiscussWeb.TopicController do
  # discuss/lib/discuss_web.ex include all the functionality for controller
  # use is a fancy wey to import the funcitonality look at the file  talked before
  use DiscussWeb, :controller 
  alias Discuss.Topic # with this we can use only Topic to call something

  def new(conn, params) do
    IO.puts "++++++"
    # inspect show every value of the data structure
    # conn is a struct represents the incoming request and the outgoing request, is as request in rails
    struct = %Topic{}
    params = %{}
    changeset = Topic.changeset(struct, params) # empty changeset

    render conn, "new.html", changeset: changeset # changeset passed as a keyword list and is going to be like an instance var in the view
    # specify which template we want to render
    # conn is passed by default in the render statement
  end
end
