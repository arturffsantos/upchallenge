defmodule Api.Account.Follower do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  schema "followers" do
    field :followed, :integer, primary_key: true
    field :follower, :integer, primary_key: true

    timestamps()
  end

  @doc false
  def changeset(follower, attrs) do
    follower
    |> cast(attrs, [:followed, :follower])
    |> validate_required([:followed, :follower])
  end
end
