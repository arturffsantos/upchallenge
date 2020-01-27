defmodule ApiWeb.LikeController do
  use ApiWeb, :controller

  alias Api.Messages
  alias Api.Messages.Tweet
  alias Api.Account.User
  alias Api.Account

  action_fallback ApiWeb.FallbackController

  def index(conn, _params) do
    tweets = Messages.list_tweets()
    render(conn, "index.json", tweets: tweets)
  end

  def create(conn, %{"tweet_ids" => tweet_ids}) do
    user = Guardian.Plug.current_resource(conn)

    with {:ok, %User{} = user} <- Account.update_user_likes(user, tweet_ids) do
      conn
      |> put_status(:created)
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    tweet = Messages.get_tweet!(id)
    render(conn, "show.json", tweet: tweet)
  end

  def update(conn, %{"id" => id, "tweet" => tweet_params}) do
    tweet = Messages.get_tweet!(id)

    with {:ok, %Tweet{} = tweet} <- Messages.update_tweet(tweet, tweet_params) do
      render(conn, "show.json", tweet: tweet)
    end
  end

  def delete(conn, %{"id" => id}) do
    tweet = Messages.get_tweet!(id)

    with {:ok, %Tweet{}} <- Messages.delete_tweet(tweet) do
      send_resp(conn, :no_content, "")
    end
  end

  def tweets_from_user(conn, %{"id" => id}) do
    tweets = Messages.list_tweets_from_user(id)
    render(conn, "index.json", tweets: tweets)
  end

  def my_tweets(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    tweets = Messages.list_tweets_from_user(user.id)
    render(conn, "index.json", tweets: tweets)
  end
end
