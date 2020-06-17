defmodule DiscussWeb.TopicController do
  # discuss/lib/discuss_web.ex include all the functionality for controller
  # use is a fancy wey to import the funcitonality look at the file  talked before
  use DiscussWeb, :controller 
  alias Discuss.Topic # with this we can use only Topic to call something
  alias Discuss.Repo

  def new(conn, _params) do
    #IO.puts "++++++"
    # inspect show every value of the data structure
    # conn is a struct represents the incoming request and the outgoing request, is as request in rails
    #struct = %Topic{}
    #params = %{}
    changeset = Topic.changeset(%Topic{}, %{}) # empty changeset

    render conn, "new.html", changeset: changeset # changeset passed as a keyword list and is going to be like an instance var in the view
    # specify which template we want to render
    # conn is passed by default in the render statement
  end

  def create(conn, %{"topic" => topic}) do
    #IO.inspect(params)
    changeset = Topic.changeset(%Topic{}, topic)

    # repo functionality is inserted by line 4
    case Repo.insert(changeset) do
      {:ok, post} -> IO.inspect(post)
      {:error, changeset} -> # if it fails we need to render again new like rails, valid?
        render conn, "new.html", changeset: changeset
    end
  end
end
