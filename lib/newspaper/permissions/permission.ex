defmodule Newspaper.Permissions.Permission do
  use Ecto.Schema
  import Ecto.Changeset

  schema "permissions" do
    field :name, :string
    field :description, :string

    many_to_many :roles, Newspaper.Roles.Role, join_through: "role_permissions"
    belongs_to :permission_category, Newspaper.PermissionCategories.PermissionCategory

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(permission, attrs) do
    permission
    |> cast(attrs, [:name, :description, :permission_category_id])
    |> validate_required([:name, :description, :permission_category_id])
    |> unique_constraint(:name)
  end
end
