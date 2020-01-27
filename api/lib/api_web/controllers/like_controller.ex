defmodule ApiWeb.LikeController do
  use ApiWeb, :controller

  alias Api.Messages
  alias Api.Messages.Like

  action_fallback ApiWeb.FallbackController

  def index(conn, _params) do
    likes = Messages.list_likes()
    render(conn, "index.json", likes: likes)
  end

  def create(conn, %{"tweet_id" => tweet_id}) do
    user = Guardian.Plug.current_resource(conn)
    like = %{:user_id => user.id, :tweet_id => tweet_id}

    with {:ok, %Like{} = like} <- Messages.create_like(like) do
      conn
      |> put_status(:created)
      |> render("show.json", like: like)
    end
  end

  def show(conn, %{"id" => id}) do
    like = Messages.get_like!(id)
    render(conn, "show.json", like: like)
  end

  def update(conn, %{"id" => id, "like" => like_params}) do
    like = Messages.get_like!(id)

    with {:ok, %Like{} = like} <- Messages.update_like(like, like_params) do
      render(conn, "show.json", like: like)
    end
  end

  def delete(conn, %{"id" => id}) do
    like = Messages.get_like!(id)

    with {:ok, %Like{}} <- Messages.delete_like(like) do
      send_resp(conn, :no_content, "")
    end
  end
end
