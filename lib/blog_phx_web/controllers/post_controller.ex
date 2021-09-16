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

  def create(conn, %{"post" => post}) do
    post =
      Post.changeset(%Post{}, post)
      |> BlogPhx.Repo.insert()

    case post do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post created successfully!")
        |> redirect(to: Routes.post_path(conn, :show, post))

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = BlogPhx.Repo.get!(Post, id)
    BlogPhx.Repo.delete!(post)

    conn
    |> put_flash(:info, "Post deleted!")
    |> redirect(to: Routes.post_path(conn, :index))
  end
end
