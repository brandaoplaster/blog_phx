defmodule BlogPhx.Repo.Migrations.RelationCommentsUser do
  @moduledoc false
  use Ecto.Migration

  def change do
    alter table(:comments) do
      add :user_id, references(:users)
    end
  end
end
