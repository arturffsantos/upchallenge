defmodule ApiWeb.TweetController do
  use ApiWeb, :controller

  alias Api.Messages
  alias Api.Messages.Tweet

  action_fallback ApiWeb.FallbackController

  def index(conn, _params) do
    tweets = Messages.list_tweets()
    render(conn, "index.json", tweets: tweets)
  end

  def create(conn, %{"text" => tweet_message}) do
    user = Guardian.Plug.current_resource(conn)
    tweet = %{:text => tweet_message, :user_id => user.id}

    with {:ok, %Tweet{} = tweet} <- Messages.create_tweet(tweet) do
      conn
      |> put_status(:created)
      |> render("show.json", tweet: tweet)
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

  def my_tweets(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    tweets = Messages.list_tweets_from_user(user.id)
    render(conn, "index.json", tweets: tweets)
  end
end
