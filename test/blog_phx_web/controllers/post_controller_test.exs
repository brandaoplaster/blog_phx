defmodule BlogPhxWeb.PostControllerTest do
  @moduledoc false
  use BlogPhxWeb.ConnCase

  alias BlogPhx.{Accounts, Posts}

  @valid_post %{
    title: "Rails",
    description: "Lorem..."
  }

  @update_post %{
    title: "update",
    description: "update"
  }

  def fixture(:post) do
    user = BlogPhx.Accounts.get_user!(1)
    {:ok, post} = BlogPhx.Posts.create_post(user, @valid_post)
    post
  end

  test "action :index for list all posts", %{conn: conn} do
    user = Accounts.get_user!(1)
    Posts.create_post(user, @valid_post)
    conn = get(conn, Routes.post_path(conn, :index))
    assert html_response(conn, 200) =~ "Rails"
  end

  test "action :show for get post by id", %{conn: conn} do
    user = Accounts.get_user!(1)
    {:ok, post} = Posts.create_post(user, @valid_post)
    conn = get(conn, Routes.post_path(conn, :show, post))
    assert html_response(conn, 200) =~ "Rails"
  end

  test "action :new for new posts", %{conn: conn} do
    conn =
      conn
      |> Plug.Test.init_test_session(user_id: 1)
      |> get(Routes.post_path(conn, :new))

    assert html_response(conn, 200) =~ "Create Post"
  end

  test "action :new for new posts without authentication", %{conn: conn} do
    conn =
      conn
      |> get(Routes.post_path(conn, :new))

    assert redirected_to(conn) == Routes.page_path(conn, :index)
    conn = get(conn, Routes.page_path(conn, :index))
    assert html_response(conn, 200) =~ "Must be authenticated!"
  end

  test "action :create for new posts", %{conn: conn} do
    conn =
      conn
      |> Plug.Test.init_test_session(user_id: 1)
      |> post(Routes.post_path(conn, :create), post: @valid_post)

    assert %{id: id} = redirected_params(conn)
    assert redirected_to(conn) == Routes.post_path(conn, :show, id)

    conn = get(conn, Routes.post_path(conn, :show, id))
    assert html_response(conn, 200) =~ "Rails"
  end

  test "when creating a post with invalid values", %{conn: conn} do
    conn =
      conn
      |> Plug.Test.init_test_session(user_id: 1)
      |> post(Routes.post_path(conn, :create), post: %{})

    assert html_response(conn, 200) =~ "can&#39;t be blank"
  end

  test "action :edit for a post", %{conn: conn} do
    user = Accounts.get_user!(1)
    {:ok, post} = Posts.create_post(user, @valid_post)

    conn =
      conn
      |> Plug.Test.init_test_session(user_id: 1)
      |> get(Routes.post_path(conn, :edit, post))

    assert html_response(conn, 200) =~ "Edit Post"
  end

  test "action :update to update a post when you don't have permission", %{conn: conn} do
    user = BlogPhx.Accounts.get_user!(1)
    {:ok, post} = BlogPhx.Posts.create_post(user, @valid_post)

    conn =
      conn
      |> Plug.Test.init_test_session(user_id: 2)
      |> get(Routes.post_path(conn, :edit, post))

    assert redirected_to(conn) == Routes.page_path(conn, :index)
    conn = get(conn, Routes.page_path(conn, :index))
    assert html_response(conn, 200) =~ "No permission for this operation."
  end

  describe "tests with dependency on created post" do
    setup [:create_post]

    test "when to change post with valid values", %{conn: conn, post: post} do
      conn =
        conn
        |> Plug.Test.init_test_session(user_id: 1)
        |> put(Routes.post_path(conn, :update, post), post: @update_post)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.post_path(conn, :show, id)

      conn = get(conn, Routes.post_path(conn, :show, id))
      assert html_response(conn, 200) =~ "update"
    end

    test "when changing post with invalid values", %{conn: conn, post: post} do
      conn =
        conn
        |> Plug.Test.init_test_session(user_id: 1)
        |> put(Routes.post_path(conn, :update, post), post: %{title: nil, description: nil})

      assert html_response(conn, 200) =~ " data-error=\"wrong\""
    end

    test "action :delete for a post", %{conn: conn, post: post} do
      conn =
        conn
        |> Plug.Test.init_test_session(user_id: 1)
        |> delete(Routes.post_path(conn, :delete, post))

      assert redirected_to(conn) == Routes.post_path(conn, :index)

      assert_error_sent 404, fn -> get(conn, Routes.post_path(conn, :show, post)) end
    end
  end

  defp create_post(_) do
    %{post: fixture(:post)}
  end
end
