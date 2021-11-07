defmodule BlogPhxWeb.PostController do
  use BlogPhxWeb, :controller

  alias BlogPhx.Posts
  alias BlogPhx.Posts.Post

  def index(conn, _params) do
    posts = Posts.list_post()
    render(conn, "index.html", posts: posts)
  end

  def show(conn, %{"id" => id}) do
    post = Posts.get_post(id)
    render(conn, "show.html", post: post)
  end

  def new(conn, _params) do
    changeset = Post.changeset(%Post{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"post" => post}) do
    case Posts.create_post(conn.assigns[:user], post) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post created successfully!")
        |> redirect(to: Routes.post_path(conn, :show, post))

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    Posts.delete_post(id)

    conn
    |> put_flash(:info, "Post deleted!")
    |> redirect(to: Routes.post_path(conn, :index))
  end

  def edit(conn, %{"id" => id}) do
    post = BlogPhx.Repo.get(Post, id)
    changeset = Post.changeset(post)
    render(conn, "edit.html", post: post, changeset: changeset)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    case Posts.update_post(id, post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post updated successfully!")
        |> redirect(to: Routes.post_path(conn, :show, post))

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
