defmodule Newspaper.Repo.Migrations.CreateUserRoles do
  use Ecto.Migration

  def change do
    create table(:user_roles) do
      add :user_id, references(:users, on_delete: :delete_all)
      add :role_id, references(:roles, on_delete: :nilify_all)

      timestamps(type: :utc_datetime)
    end

    create index(:user_roles, [:user_id])
    create index(:user_roles, [:role_id])
  end
end
