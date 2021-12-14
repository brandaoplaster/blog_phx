defmodule BlogPhx.Comments.Comment do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  alias BlogPhx.Accounts.User
  alias BlogPhx.Posts.Post

  @derive {Jason.Encoder, only: [:content, :user]}
  schema "comments" do
    field :content, :string

    belongs_to :post, Post
    belongs_to :user, User

    timestamps()
  end

  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:content])
    |> validate_required([:content])
  end
end
