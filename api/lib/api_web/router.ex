defmodule ApiWeb.Router do
  use ApiWeb, :router

  alias Api.Guardian

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :jwt_authenticated do
    plug Guardian.AuthPipeline
  end

  scope "/api/v1", ApiWeb do
    pipe_through :api

    post "/sign_up", UserController, :create
    post "/sign_in", UserController, :sign_in
  end

  scope "/api/v1", ApiWeb do
    pipe_through [:api, :jwt_authenticated]

    get "/my_user", UserController, :show
    get "/my_tweets", TweetController, :my_tweets

    get "/tweets/:id", TweetController, :show
    get "/tweets", TweetController, :index
    get "/users/:id/tweets", TweetController, :tweets_from_user
    post "/tweets", TweetController, :create

    post "/likes/:tweet_id", LikeController, :create
    delete "/likes/:tweet_id", LikeController, :delete
  end
end
