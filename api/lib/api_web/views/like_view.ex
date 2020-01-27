defmodule ApiWeb.LikeView do
  use ApiWeb, :view
  alias ApiWeb.LikeView

  def render("index.json", %{likes: likes}) do
    %{data: render_many(likes, LikeView, "like.json")}
  end

  def render("show.json", %{like: like}) do
    %{data: render_one(like, LikeView, "like.json")}
  end

  def render("like.json", %{like: like}) do
    %{user_id: like.user_id, tweet_id: like.tweet_id}
  end
end
