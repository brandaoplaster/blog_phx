defmodule BlogPhx.Posts.PostTest do
  @moduledoc false
  use BlogPhx.DataCase

  alias BlogPhx.Posts
  alias BlogPhx.Posts.Post

  @valid_post %{
    title: "Rails",
    description: "Lorem..."
  }

  @update_post %{
    title: "Ruby on Rails",
    description: "Lorem..."
  }

  def post_fixture(_attrs \\ %{}) do
    {:ok, post} = Posts.create_post(@valid_post)
    post
  end

  test "create_post/1 with valid params" do
    assert {:ok, %Post{} = post} = Posts.create_post(@valid_post)
    assert post.title == "Rails"
    assert post.description == "Lorem..."
  end

  test "list_post/0 return all posts" do
    post = post_fixture()
    assert Posts.list_post() == [post]
  end

  test "get_post/1 return all posts" do
    post = post_fixture()
    assert Posts.get_post(post.id) == post
  end

  test "update_post/2 with valid params" do
    post = post_fixture()
    assert {:ok, %Post{} = post} = Posts.update_post(post.id, @update_post)

    assert post.title == "Ruby on Rails"
    assert post.description == "Lorem..."
  end

  test "delete/1" do
    post = post_fixture()
    assert post = Posts.delete_post(post.id)
    assert_raise Ecto.NoResultsError, fn -> Posts.get_post(post.id) end
  end
end
