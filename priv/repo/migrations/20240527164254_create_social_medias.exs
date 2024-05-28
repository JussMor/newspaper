defmodule Newspaper.Repo.Migrations.CreateSocialMedias do
  use Ecto.Migration

  def change do
    create table(:social_medias) do
      add :platform, :string
      add :url, :string
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end

    create index(:social_medias, [:user_id])
  end
end
