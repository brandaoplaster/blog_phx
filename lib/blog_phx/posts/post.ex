defmodule BlogPhx.Posts.Post do
  @moduledoc """
  Module Post
  """
  use Ecto.Schema
  import Ecto.Changeset

  @required_fields ~w(title description)a

  schema "posts" do
    field :title, :string
    field :description, :string

    timestamps()
  end

  def changeset(post, attr) do
    post
    |> cast(attr, @required_fields)
    |> validate_required(@required_fields)
  end
end
