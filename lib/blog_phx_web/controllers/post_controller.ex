defmodule BlogPhxWeb.PostController do
  use BlogPhxWeb, :controller

  alias BlogPhx.Posts.Post

  def index(conn, _params) do
    posts = BlogPhx.Repo.all(Post)
    render(conn, "index.html", posts: posts)
  end

  def show(conn, %{"id" => id}) do
    post = BlogPhx.Repo.get!(Post, id)
    render(conn, "show.html", post: post)
  end

  def new(conn, _params) do
    changeset = Post.changeset(%Post{})
    render(conn, "new.html", changeset: changeset)
  end
end
