defmodule Newspaper.RolPermissions.RolPermission do
  use Ecto.Schema
  import Ecto.Changeset

  schema "role_permissions" do

    belongs_to :role, Newspaper.Roles.Role
    belongs_to :permission, Newspaper.Permissions.Permission

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(rol_permission, attrs) do
    rol_permission
    |> cast(attrs, [:role_id, :permission_id])
    |> validate_required([:role_id, :permission_id])
  end
end
