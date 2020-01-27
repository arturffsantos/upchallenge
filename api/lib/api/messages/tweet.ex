defmodule Api.Messages.Tweet do
  use Ecto.Schema
  import Ecto.Changeset
  alias Api.Account.User

  schema "tweets" do
    field :text, :string
    belongs_to :user, User

    many_to_many(
      :users,
      User,
      join_through: "likes",
      on_replace: :delete
    )

    timestamps()
  end

  @doc false
  def changeset(tweet, attrs) do
    tweet
    |> cast(attrs, [:text, :user_id])
    |> validate_required([:text, :user_id])
  end
end
