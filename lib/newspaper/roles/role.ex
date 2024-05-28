defmodule Newspaper.Roles.Role do
  use Ecto.Schema
  import Ecto.Changeset

  schema "roles" do
    field :name, :string
    field :description, :string

    has_many :role_permissions, Newspaper.RolPermissions.RolPermission
    has_many :permissions, through: [:role_permissions, :permission]
    has_many :user_roles, Newspaper.UserRoles.UserRole
    has_many :users, through: [:user_roles, :user]

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(role, attrs) do
    role
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
    |> unique_constraint(:name)
  end
end
