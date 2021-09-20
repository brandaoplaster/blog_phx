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
end
