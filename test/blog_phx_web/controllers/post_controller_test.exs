defmodule BlogPhxWeb.PostControllerTest do
  @moduledoc false
  use BlogPhxWeb.ConnCase

  alias BlogPhx.Posts

  @valid_post %{
    title: "Rails",
    description: "Lorem..."
  }

  test "action :index for list all posts", %{conn: conn} do
    Posts.create_post(@valid_post)
    conn = get(conn, Routes.post_path(conn, :index))
    assert html_response(conn, 200) =~ "Rails"
  end

  test "action :show for get post by id", %{conn: conn} do
    {:ok, post} = Posts.create_post(@valid_post)
    conn = get(conn, Routes.post_path(conn, :show, post))
    assert html_response(conn, 200) =~ "Rails"
  end

  test "action :new for new posts", %{conn: conn} do
    conn = get(conn, Routes.post_path(conn, :new))
    assert html_response(conn, 200) =~ "Create Post"
  end
end
