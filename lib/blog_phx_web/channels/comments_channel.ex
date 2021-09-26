defmodule BlogPhxWeb.CommentsChannel do
  @moduledoc """
  Channel to comments
  """
  use BlogPhxWeb, :channel

  def join("comments:"<> post_id, _payload, socket) do
    post = BlogPhx.Posts.get_post_with_comments(post_id)
    {:ok, %{comments: post.commments}, socket}
  end

  def handle_in() do

  end
end
