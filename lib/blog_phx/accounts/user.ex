defmodule BlogPhx.Accounts.User do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  alias BlogPhx.Comments.Comment
  alias BlogPhx.Posts.Post

  @derive {Jason.Encoder, only: [:email, :image]}

  schema "users" do
    field :email, :string
    field :first_name, :string
    field :image, :string
    field :last_name, :string
    field :provider, :string
    field :token, :string

    has_many :posts, Post
    has_many :comments, Comment

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:first_name, :last_name, :image, :provider, :email, :token])
    |> validate_required([:provider, :email, :token])
  end
end
