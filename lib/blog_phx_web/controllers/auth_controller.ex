defmodule BlogPhxWeb.AuthController do
  use BlogPhxWeb, :controller

  def request(conn, _params) do
    render(conn, "index.html")
  end

  def callback(conn, _params) do
    render(conn, "index.html")
  end
end
