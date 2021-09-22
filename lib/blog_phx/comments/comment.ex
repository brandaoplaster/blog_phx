defmodule BlogPhx.Comments.Comment do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  alias BlogPhx.Posts.Post

  schema "comments" do
    field :content, :string

    belongs_to :post, Post

    timestamps()
  end

  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:content])
    |> validate_required([:content])
  end
end
