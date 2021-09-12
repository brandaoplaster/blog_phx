defmodule BlogPhxWeb.PostController do
  use BlogPhxWeb, :controller

  alias BlogPhx.Posts.Post

  def index(conn, _params) do
    posts = BlogPhx.Repo.all(Post)
    render(conn, "index.html", posts: posts)
  end
end
