defmodule BlogPhxWeb.AuthControllerTest do
  @moduledoc false
  use BlogPhxWeb.ConnCase

  @ueberauth %Ueberauth.Auth{
    credentials: %{
      token: "qwertyuiop"
    },
    info: %{
      email: "user@test.com",
      first_name: "user_1",
      last_name: "last_name_user",
      image: "image.jpg"
    },
    provider: "google"
  }

  @ueberauth_error %Ueberauth.Auth{
    credentials: %{
      token: nil
    },
    info: %{
      email: "nil@test.com",
      first_name: nil,
      last_name: nil,
      image: nil
    },
    provider: nil
  }

  test "callback success", %{conn: conn} do
    conn =
      conn
      |> assign(:ueberauth_auth, @ueberauth)
      |> get(Routes.auth_path(conn, :callback, "google"))

    assert redirected_to(conn) == Routes.page_path(conn, :index)
    conn = get(conn, Routes.page_path(conn, :index))
    assert html_response(conn, 200) =~ "Welcome to Blog PHX"
  end

  test "callback error", %{conn: conn} do
    conn =
      conn
      |> assign(:ueberauth_auth, @ueberauth_error)
      |> get(Routes.auth_path(conn, :callback, "google"))

    assert redirected_to(conn) == Routes.page_path(conn, :index)
    conn = get(conn, Routes.page_path(conn, :index))
    assert html_response(conn, 200) =~ "Welcome to Blog PHX"
  end

  test "logout success", %{conn: conn} do
    conn =
      conn
      |> Plug.Test.init_test_session(user_id: 2)
      |> get(Routes.auth_path(conn, :logout))

    assert redirected_to(conn) == Routes.page_path(conn, :index)
  end
end
