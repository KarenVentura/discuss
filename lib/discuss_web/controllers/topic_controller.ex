defmodule DiscussWeb.TopicController do
  # discuss/lib/discuss_web.ex include all the functionality for controller
  # use is a fancy wey to import the funcitonality look at the file  talked before
  use DiscussWeb, :controller 
  alias Discuss.Topic # with this we can use only Topic to call something
  alias Discuss.Repo

  def new(conn, _params) do
    # IO.puts "++++++"
    # inspect show every value of the data structure
    # conn is a struct represents the incoming request and the outgoing request, is as request in rails
    # struct = %Topic{}
    # ccparams = %{}
    changeset = Topic.changeset(%Topic{}, %{}) # empty changeset

    render conn, "new.html", changeset: changeset # changeset passed as a keyword list and is going to be like an instance var in the view
    # specify which template we want to render
    # conn is passed by default in the render statement
  end

  def index(conn, _params) do
    topics = Repo.all(Topic) # Discuss.Repo.all(Discuss.Topic)
    render conn, "index.html", topics: topics
  end

  def edit(conn, %{"id" => topic_id}) do
    topic = Repo.get(Topic, topic_id)
    changeset = Topic.changeset(topic)
    
    render conn, "edit.html", changeset: changeset, topic: topic
  end

  def create(conn, %{"topic" => topic}) do
    #IO.inspect(params)
    changeset = Topic.changeset(%Topic{}, topic)

    # repo functionality is inserted by line 4
    case Repo.insert(changeset) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic created") # set flash message
        |> redirect(to: Routes.topic_path(conn, :index)) # redirect when the status is ok and the topic is created
      {:error, changeset} -> # if it fails we need to render again new like rails, valid?
        render conn, "new.html", changeset: changeset
    end
  end

  def update(conn, %{"id" => topic_id, "topic" => topic}) do
    old_topic = Repo.get(Topic, topic_id)
    changeset = Topic.changeset(old_topic, topic)
    # the same as the following code
    # changeset = Repo.get(Topic, topic_id) |> Topic.changeset(topic)
    
    case Repo.update(changeset) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic updated") # set flash message
        |> redirect(to: Routes.topic_path(conn, :index)) # redirect when the status is ok and the topic is created
      {:error, changeset} -> # if it fails we need to render again new like rails, valid?
        render conn, "edit.html", changeset: changeset, topic: old_topic # we are sending old topic because edit action use it
    end
  end
end
