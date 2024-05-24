defmodule Newspaper.Repo.Migrations.CreateLasnews do
  use Ecto.Migration

  def change do
    create table(:lasnews) do
      add :url, :string
      add :cover, :string
      add :created_at, :date
      add :title_feed, :string
      add :title_excerpt, :string
      add :resume, :text

      timestamps(type: :utc_datetime)
    end
  end
end
