defmodule Discuss.Topic do
  #use Discuss.Web, :model
  use Ecto.Schema
  import Ecto.Changeset
  alias Discuss.Topic

  schema "topics" do # way of link your database table with the current model and say what fields are you going to use
    field :title, :string
  end

  @doc false
  def changeset(%Topic{} = topic, attrs) do # attrs \\ %{} -> is like attrs = {} in ruby, a default value
    # struct represents the record in our database
    # params are the values we want to update our record with
    # cast produces the changeset, the object that records the updates in our db that we need to make
    topic
    |> cast(attrs, [:title])
    |> validate_required([:title]) # rails require_attribute
    # in console I ran struct = %Discuss.Topic{} to see an example
    # attrs = %{ title: "Postgres"}
    # Discuss.Topic.changeset(struct, attrs) valid record
    # Discuss.Topic.changeset(struct, %{}) invalid record because title is required
  end
end