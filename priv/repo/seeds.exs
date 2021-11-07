# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     BlogPhx.Repo.insert!(%BlogPhx.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias BlogPhx.{Accounts, Posts}

user_params = %{
  token: "token-asihaish",
  email: "test@test.com",
  first_name: "first test",
  last_name: "last test",
  image: "link image",
  provider: "google"
}

post_params = %{
  title: "PG",
  description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.
    Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,
    when an unknown printer took a galley of type and scrambled it to make a type
    specimen book. It has survived not only five centuries, but also the leap
    into electronic typesetting, remaining essentially unchanged. It was
    popularised in the 1960s with the release of Letraset sheets containing
    Lorem Ipsum passages, and more recently with desktop publishing software
    like Aldus PageMaker including versions of Lorem Ipsum."
}

{:ok, user} = Accounts.create_user(user_params)
{:ok, _post} = Posts.create_post(user, post_params)
