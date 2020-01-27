defmodule Api.Messages.Like do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  schema "likes" do
    field :user_id, :integer, primary_key: true
    field :tweet_id, :integer, primary_key: true
  end

  @doc false
  def changeset(like, attrs) do
    like
    |> cast(attrs, [:user_id, :tweet_id])
    |> validate_required([:user_id, :tweet_id])
    |> foreign_key_constraint(:tweet_id, message: "invalid tweet")
    |> foreign_key_constraint(:user_id, message: "invalid user")
  end
end