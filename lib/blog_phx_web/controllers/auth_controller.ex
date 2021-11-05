defmodule BlogPhxWeb.AuthController do
  use BlogPhxWeb, :controller

  plug Ueberauth

  alias BlogPhx.Accounts

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, %{"provider" => provider}) do
    user = %{
      token: auth.credentials.token,
      email: auth.info.email,
      first_name: auth.info.first_name,
      last_name: auth.info.last_name,
      image: auth.info.image,
      provider: provider
    }

    case Accounts.create_user(user) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Wellcome #{user.email}")
        |> put_session(:user_id, user.id)
        |> redirect(to: Routes.page_path(conn, :index))

      {:error, _error} ->
        conn
        |> put_flash(:info, "Something went wrong!")
        |> redirect(to: Routes.page_path(conn, :index))
    end
  end

  def logout(conn, _) do
    conn
    |> configure_session(drop: true)
    |> redirect(to: Routes.page_path(conn, :index))
  end
end
