defmodule Newspaper.UserPermissionsTest do
  use Newspaper.DataCase

  alias Newspaper.UserPermissions

  describe "user_permissions" do
    alias Newspaper.UserPermissions.UserPermission

    import Newspaper.UserPermissionsFixtures

    @invalid_attrs %{}

    test "list_user_permissions/0 returns all user_permissions" do
      user_permission = user_permission_fixture()
      assert UserPermissions.list_user_permissions() == [user_permission]
    end

    test "get_user_permission!/1 returns the user_permission with given id" do
      user_permission = user_permission_fixture()
      assert UserPermissions.get_user_permission!(user_permission.id) == user_permission
    end

    test "create_user_permission/1 with valid data creates a user_permission" do
      valid_attrs = %{}

      assert {:ok, %UserPermission{} = user_permission} = UserPermissions.create_user_permission(valid_attrs)
    end

    test "create_user_permission/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = UserPermissions.create_user_permission(@invalid_attrs)
    end

    test "update_user_permission/2 with valid data updates the user_permission" do
      user_permission = user_permission_fixture()
      update_attrs = %{}

      assert {:ok, %UserPermission{} = user_permission} = UserPermissions.update_user_permission(user_permission, update_attrs)
    end

    test "update_user_permission/2 with invalid data returns error changeset" do
      user_permission = user_permission_fixture()
      assert {:error, %Ecto.Changeset{}} = UserPermissions.update_user_permission(user_permission, @invalid_attrs)
      assert user_permission == UserPermissions.get_user_permission!(user_permission.id)
    end

    test "delete_user_permission/1 deletes the user_permission" do
      user_permission = user_permission_fixture()
      assert {:ok, %UserPermission{}} = UserPermissions.delete_user_permission(user_permission)
      assert_raise Ecto.NoResultsError, fn -> UserPermissions.get_user_permission!(user_permission.id) end
    end

    test "change_user_permission/1 returns a user_permission changeset" do
      user_permission = user_permission_fixture()
      assert %Ecto.Changeset{} = UserPermissions.change_user_permission(user_permission)
    end
  end
end
