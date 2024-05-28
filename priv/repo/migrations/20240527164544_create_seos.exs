defmodule Newspaper.Repo.Migrations.CreateSeos do
  use Ecto.Migration

  def change do
    create table(:seos) do
      add :title, :string
      add :description, :text
      add :keywords, :string
      add :article_id, references(:articles, on_delete: :delete_all), null: false

      timestamps(type: :utc_datetime)
    end

    create unique_index(:seos, [:article_id]) # Ensure one-to-one relationship
  end
end
