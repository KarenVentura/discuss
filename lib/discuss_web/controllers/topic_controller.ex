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
    changeset = Topic.changeset(struct, params)
  end
end
