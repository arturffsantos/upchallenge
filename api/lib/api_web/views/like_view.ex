defmodule ApiWeb.LikeView do
  use ApiWeb, :view
  alias ApiWeb.LikeView

  def render("show.json", _params) do
    %{data: %{status: "OK"}}
  end
end
