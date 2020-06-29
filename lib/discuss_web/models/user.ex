defmodule Discuss.User do
  #use Discuss.Web, :model
  use Ecto.Schema
  import Ecto.Changeset
  alias Discuss.User # new sintax for version 1.5.3

  schema "users" do
    field :email, :string
    field :provider, :string
    field :token, :string
    has_many :topics, Discuss.Topic

    timestamps()
  end

  def changeset(struct = user, attrs \\ %{}) do
    struct
    |> cast(attrs, [:email, :provider, :token])
    |> validate_required([:email, :provider, :token])
  end
end