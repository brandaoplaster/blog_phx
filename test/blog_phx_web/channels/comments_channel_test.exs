defmodule BlogPhxWeb.CommentsChannelTest do
  @moduledoc false

  use BlogPhxWeb.ChannelCase

  alias BlogPhx.Posts
  alias BlogPhxWeb.UserSocket

  @valid_post %{
    title: "Ruby",
    description: "Lorem"
  }

  setup do
    {:ok, post} = Posts.create_post(@valid_post)
    {:ok, socket} = connect(UserSocket, %{})

    {:ok, socket: socket, post: post}
  end

  test "must connect to socket", %{socket: socket, post: post} do
    {:ok, comments, socket} = subscribe_and_join(socket, "comments:#{post.id}", %{})

    assert post.id == socket.assigns.post_id
    assert [] == comments.comments
  end

  test "when to create a new comment", %{socket: socket, post: post} do
    {:ok, comments, socket} = subscribe_and_join(socket, "comments:#{post.id}", %{})

    ref = push(socket, "comment:add", %{"content" => "test comment"})

    message = %{comment: %{content: "test comment"}}
    assert_reply ref, :ok, %{}
    broadcast_event = "comments:#{post.id}:new"

    assert_broadcast broadcast_event, message
    refute is_nil(message)
  end
end
