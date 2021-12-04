defmodule BlogPhxWeb.Plug.RequiredAuth do
  @moduledoc false

  use BlogPhxWeb, :controller

  def init(_), do: nil

  def call(conn, _) do
    if conn.assigns[:user] do
      conn
    else
      conn
      |> put_flash(:error, "Must be authenticated!")
      |> redirect(to: Routes.page_path(conn, :index))
      |> halt()
    end
  end
end
