defmodule Api.Account.User do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, warn: false

  alias Api.Repo
  alias Api.Account
  alias Api.Messages.Tweet
  alias Api.Account.User

  schema "users" do
    field :email, :string
    field :password_hash, :string
    field :user_name, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    many_to_many(
      :tweets,
      Tweet,
      join_through: "likes",
      on_replace: :delete
    )

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :password, :password_confirmation, :user_name])
    |> validate_required([:email, :password, :password_confirmation, :user_name])
    # Check that email is valid
    |> validate_format(:email, ~r/@/)
    # Check that password length is >= 8
    |> validate_length(:password, min: 8)
    # Check that password === password_confirmation
    |> validate_confirmation(:password)
    |> unique_constraint(:email)
    |> unique_constraint(:user_name)
    |> put_password_hash
  end

  def changeset_update_tweets(%User{} = user, tweets) do
    user
    |> cast(%{}, [:id])
    # associate tweets to the user
    |> put_assoc(:tweets, tweets)
  end

  def upsert_user_tweets(user, tweets_ids) when is_list(tweets_ids) do
    query = from t in Tweet, where: t.id in ^tweets_ids, select: t
    tweets = Repo.all(query)

    with {:ok, _struct} <-
           user
           |> User.changeset_update_tweets(tweets)
           |> Repo.update() do
      {:ok, Account.get_user!(user.id)}
    else
      error ->
        error
    end
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Bcrypt.hash_pwd_salt(pass))

      _ ->
        changeset
    end
  end
end
