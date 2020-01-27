defmodule Api.Account.Follower do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  schema "followers" do
    field :followed_id, :integer, primary_key: true
    field :follower_id, :integer, primary_key: true

    timestamps()
  end

  @doc false
  def changeset(follower, attrs) do
    follower
    |> cast(attrs, [:followed_id, :follower_id])
    |> validate_required([:followed_id, :follower_id])
    |> foreign_key_constraint(:followed_id, message: "invalid user")
    |> foreign_key_constraint(:follower_id, message: "invalid user")
    |> unique_constraint(:followed_id,
      name: :followers_followed_id_follower_id_index,
      message: "already following"
    )
  end
end
