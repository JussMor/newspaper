defmodule Newspaper.PermissionsCategory do
  alias Newspaper.Repo
  alias Newspaper.Permissions.Permission
  alias Newspaper.PermissionCategories.PermissionCategory

  def get_categorized_permissions do
    permissions = Repo.all(Permission) |> Repo.preload(:permission_category)

    permissions
    |> Enum.group_by(& &1.permission_category.name)
    |> Enum.reduce(%{}, fn {category, perms}, acc ->
      perms_list = Enum.map(perms, fn perm -> %{id: perm.id, name: perm.name} end)
      Map.put(acc, category, perms_list)
    end)
  end

  def create_permission_category(attrs \\ %{}) do
    %PermissionCategory{}
    |> PermissionCategory.changeset(attrs)
    |> Repo.insert()
  end

  def create_permission(attrs \\ %{}) do
    %Permission{}
    |> Permission.changeset(attrs)
    |> Repo.insert()
  end
end
