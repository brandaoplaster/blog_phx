defmodule BlogPhx.Repo do
  use Ecto.Repo,
    otp_app: :blog_phx,
    adapter: Ecto.Adapters.Postgres
end
