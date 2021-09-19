defmodule BlogPhx.Posts.PostTest do
  @moduledoc false
  use BlogPhx.DataCase

  alias BlogPhx.Posts
  alias BlogPhx.Posts.Post

  @valid_post %{
    title: "Rails",
    description: "Lorem..."
  }

  test "create_post/1 with valid params" do
    assert {:ok, %Post{} = post} = Posts.create_post(@valid_post)
    assert post.title == "Rails"
    assert post.description == "Lorem..."
  end
end
