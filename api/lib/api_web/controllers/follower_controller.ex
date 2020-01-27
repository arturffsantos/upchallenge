defmodule ApiWeb.FollowerController do
  use ApiWeb, :controller

  alias Api.Account
  alias Api.Account.Follower

  action_fallback ApiWeb.FallbackController

  def index(conn, _params) do
    followers = Account.list_followers()
    render(conn, "index.json", followers: followers)
  end

  def create(conn, %{"followed_id" => followed_id}) do
    user = Guardian.Plug.current_resource(conn)
    follow = %{:follower_id => user.id, :followed_id => followed_id}

    with {:ok, %Follower{} = follower} <- Account.create_follower(follow) do
      conn
      |> put_status(:created)
      |> render("show.json", follower: follower)
    else
      :error ->
        send_resp(conn, :error, "not found")
    end
  end

  def show(conn, %{"id" => id}) do
    follower = Account.get_follower!(id)
    render(conn, "show.json", follower: follower)
  end

  def update(conn, %{"id" => id, "follower" => follower_params}) do
    follower = Account.get_follower!(id)

    with {:ok, %Follower{} = follower} <- Account.update_follower(follower, follower_params) do
      render(conn, "show.json", follower: follower)
    end
  end

  def delete(conn, %{"id" => id}) do
    follower = Account.get_follower!(id)

    with {:ok, %Follower{}} <- Account.delete_follower(follower) do
      send_resp(conn, :no_content, "")
    end
  end
end
