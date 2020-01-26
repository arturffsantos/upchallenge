defmodule ApiWeb.TweetController do
  use ApiWeb, :controller

  alias Api.Messages
  alias Api.Messages.Tweet

  action_fallback ApiWeb.FallbackController

  def index(conn, _params) do
    tweets = Messages.list_tweets()
    render(conn, "index.json", tweets: tweets)
  end

  def create(conn, %{"tweet" => tweet_params}) do
    with {:ok, %Tweet{} = tweet} <- Messages.create_tweet(tweet_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.tweet_path(conn, :show, tweet))
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
end
