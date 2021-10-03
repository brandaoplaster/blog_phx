defmodule BlogPhx.Posts do
  @moduledoc """
  Module posts
  """

  alias BlogPhx.Posts.Post
  alias BlogPhx.Repo

  def list_post, do: Repo.all(Post)

  def get_post(id), do: Repo.get!(Post, id)

  def get_post_with_comments(id) do
    Repo.get!(Post, id)
    |> Repo.preload(:comments)
  end

  def create_post(attrs \\ %{}) do
    %Post{}
    |> Post.changeset(attrs)
    |> Repo.insert()
  end

  def update_post(id, post_params) do
    get_post(id)
    |> Post.changeset(post_params)
    |> Repo.update()
  end

  def delete_post(id) do
    get_post(id)
    |> Repo.delete!()
  end
end
