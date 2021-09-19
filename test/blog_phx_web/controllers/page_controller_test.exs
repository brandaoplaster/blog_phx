defmodule BlogPhxWeb.PageControllerTest do
  @moduledoc false
  use BlogPhxWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Welcome to Blog PHX"
  end
end
