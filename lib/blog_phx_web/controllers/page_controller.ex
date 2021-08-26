defmodule BlogPhxWeb.PageController do
  use BlogPhxWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
