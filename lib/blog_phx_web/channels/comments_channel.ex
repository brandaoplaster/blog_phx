defmodule BlogPhxWeb.CommentsChannel do
  @moduledoc """
  Channel to comments
  """
  use BlogPhxWeb, :channel

  def join("comments:" <> post_id, _payload, socket) do
    post = BlogPhx.Posts.get_post_with_comments(post_id)
    {:ok, %{comments: post.commments}, assign(socket, :post_id, post.id)}
  end

  def handle_in("comment:add", content, socket) do
    response =
      socket.assigns.post_id
      |> BlogPhx.Comments.create_comment(content)

    {:reply, :ok, socket}
  end
end
