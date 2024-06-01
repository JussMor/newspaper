defmodule Newspaper.Repo.Migrations.CreatePermissionCategories do
  use Ecto.Migration

  def change do
    create table(:permission_categories) do
      add :name, :string, null: false
      add :description, :text

      timestamps()
    end

    create unique_index(:permission_categories, [:name])

    alter table(:permissions) do
      add :permission_category_id, references(:permission_categories, on_delete: :delete_all)
    end

    create index(:permissions, [:permission_category_id])
  end
end
