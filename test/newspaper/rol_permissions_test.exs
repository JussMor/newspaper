defmodule Newspaper.RolPermissionsTest do
  use Newspaper.DataCase

  alias Newspaper.RolPermissions

  describe "rol_permissions" do
    alias Newspaper.RolPermissions.RolPermission

    import Newspaper.RolPermissionsFixtures

    @invalid_attrs %{}

    test "list_rol_permissions/0 returns all rol_permissions" do
      rol_permission = rol_permission_fixture()
      assert RolPermissions.list_rol_permissions() == [rol_permission]
    end

    test "get_rol_permission!/1 returns the rol_permission with given id" do
      rol_permission = rol_permission_fixture()
      assert RolPermissions.get_rol_permission!(rol_permission.id) == rol_permission
    end

    test "create_rol_permission/1 with valid data creates a rol_permission" do
      valid_attrs = %{}

      assert {:ok, %RolPermission{} = rol_permission} = RolPermissions.create_rol_permission(valid_attrs)
    end

    test "create_rol_permission/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = RolPermissions.create_rol_permission(@invalid_attrs)
    end

    test "update_rol_permission/2 with valid data updates the rol_permission" do
      rol_permission = rol_permission_fixture()
      update_attrs = %{}

      assert {:ok, %RolPermission{} = rol_permission} = RolPermissions.update_rol_permission(rol_permission, update_attrs)
    end

    test "update_rol_permission/2 with invalid data returns error changeset" do
      rol_permission = rol_permission_fixture()
      assert {:error, %Ecto.Changeset{}} = RolPermissions.update_rol_permission(rol_permission, @invalid_attrs)
      assert rol_permission == RolPermissions.get_rol_permission!(rol_permission.id)
    end

    test "delete_rol_permission/1 deletes the rol_permission" do
      rol_permission = rol_permission_fixture()
      assert {:ok, %RolPermission{}} = RolPermissions.delete_rol_permission(rol_permission)
      assert_raise Ecto.NoResultsError, fn -> RolPermissions.get_rol_permission!(rol_permission.id) end
    end

    test "change_rol_permission/1 returns a rol_permission changeset" do
      rol_permission = rol_permission_fixture()
      assert %Ecto.Changeset{} = RolPermissions.change_rol_permission(rol_permission)
    end
  end
end
