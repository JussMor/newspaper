defmodule Newspaper.PermissionCategories.PermissionCategory do
  use Ecto.Schema
  import Ecto.Changeset

  schema "permission_categories" do
    field :name, :string
    field :description, :string

    has_many :permissions, Newspaper.Permissions.Permission

    timestamps(type: :utc_datetime)
  end

  def changeset(permission_category, attrs) do
    permission_category
    |> cast(attrs, [:name, :description])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
