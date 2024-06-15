defmodule Newspaper.PermissionCategories do

  import Ecto.Query, warn: false
  alias Newspaper.Repo
  alias Newspaper.Permissions.Permission
  alias Newspaper.PermissionCategories.PermissionCategory

  def get_categorized_permissions do
    permissions = Repo.all(Permission) |> Repo.preload(:permission_category)

    permissions
    |> Enum.group_by(& &1.permission_category.id)
    |> Enum.map(fn {_, perms} ->
      category = perms |> List.first() |> Map.get(:permission_category)
      perms_list = Enum.map(perms, fn perm -> %{id: perm.id, name: perm.name} end)
      %{id: category.id, category: category.name, permissions: perms_list}
    end)
  end

  def create_permission_category(attrs \\ %{}) do
    %PermissionCategory{}
    |> PermissionCategory.changeset(attrs)
    |> Repo.insert()
  end

  def get_permission_category!(id) do
    Repo.get!(PermissionCategory, id)
  end


  def delete_selected_permissions(%PermissionCategory{} = category) do
    Repo.delete(category)
  end

  def create_category_with_permissions(category_attrs) do
    %PermissionCategory{}
    |> PermissionCategory.changeset(category_attrs)
    |> Repo.insert()
    |> case do
      {:ok, category} ->
        permissions = predefined_permissions(category.name)
        permissions = Enum.map(permissions, &Map.put(&1, :permission_category_id, category.id))

        inserted_permissions = for permission <- permissions do
          case Repo.insert(permission) do
            {:ok, permission} -> permission
            {:error, changeset} ->
              IO.inspect(changeset.errors, label: "Error inserting permission #{permission.name}")
              nil
          end
        end
        |> Enum.filter(& &1) # Filter out nil values

        {:ok, category, inserted_permissions}
      {:error, changeset} ->
        {:error, changeset}
    end
  end

  def update_category_with_permissions(%PermissionCategory{} = category, attrs) do
    PermissionCategory.changeset(category, attrs)
    |> Repo.update()
    |> case do
      {:ok, category} ->
        permissions = predefined_permissions(category.name)
        permissions = Enum.map(permissions, &Map.put(&1, :permission_category_id, category.id))

        inserted_permissions = for permission <- permissions do
          case Repo.insert(permission) do
            {:ok, permission} -> permission
            {:error, changeset} ->
              IO.inspect(changeset.errors, label: "Error inserting permission #{permission.name}")
              nil
          end
        end
        |> Enum.filter(& &1) # Filter out nil values

        {:ok, category, inserted_permissions}
      {:error, changeset} ->
        {:error, changeset}
    end
  end

  def predefined_permissions(category_name) do
    [
      %Permission{name: "update_#{category_name}", description: "Update #{category_name}"},
      %Permission{name: "delete_#{category_name}", description: "Delete #{category_name}"},
      %Permission{name: "insert_#{category_name}", description: "Insert #{category_name}"},
      %Permission{name: "publish_#{category_name}", description: "Publish #{category_name}"},
      %Permission{name: "read_#{category_name}_only", description: "Read-only #{category_name}"}
    ]
  end

  def change_permission_category(%PermissionCategory{} = permission_category, attrs \\ %{}) do
    PermissionCategory.changeset(permission_category, attrs)
  end

end
