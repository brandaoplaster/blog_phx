defmodule BlogPhx.Repo.Migrations.CreatePostsTable do
  @moduledoc false
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string
      add :description, :text

      timestamps()
    end
  end
end
