defmodule Newspaper.Repo.Migrations.CreateRolPermissions do
  use Ecto.Migration

  def change do
    create table(:role_permissions) do
      add :role_id, references(:roles, on_delete: :delete_all)
      add :permission_id, references(:permissions, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end

    create index(:role_permissions, [:role_id])
    create index(:role_permissions, [:permission_id])
  end
end
