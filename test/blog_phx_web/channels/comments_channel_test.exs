defmodule BlogPhxWeb.CommentsChannelTest do
  @moduledoc false

  use BlogPhxWeb.ChannelCase

  alias BlogPhx.Posts
  alias BlogPhxWeb.UserSocket

  @valid_post %{
    title: "Ruby",
    description: "Lorem"
  }

  test "must connect to socket" do
    {:ok, post} = Posts.create_post(@valid_post)
    {:ok, socket} = connect(UserSocket, %{})
    {:ok, comments, socket} = subscribe_and_join(socket, "comments:#{post.id}", %{})

    assert post.id == socket.assigns.post_id
    assert [] == comments.comments
  end
end
