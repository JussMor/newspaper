defmodule Newspaper.UserRolesTest do
  use Newspaper.DataCase

  alias Newspaper.UserRoles

  describe "user_roles" do
    alias Newspaper.UserRoles.UserRole

    import Newspaper.UserRolesFixtures

    @invalid_attrs %{}

    test "list_user_roles/0 returns all user_roles" do
      user_role = user_role_fixture()
      assert UserRoles.list_user_roles() == [user_role]
    end

    test "get_user_role!/1 returns the user_role with given id" do
      user_role = user_role_fixture()
      assert UserRoles.get_user_role!(user_role.id) == user_role
    end

    test "create_user_role/1 with valid data creates a user_role" do
      valid_attrs = %{}

      assert {:ok, %UserRole{} = user_role} = UserRoles.create_user_role(valid_attrs)
    end

    test "create_user_role/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = UserRoles.create_user_role(@invalid_attrs)
    end

    test "update_user_role/2 with valid data updates the user_role" do
      user_role = user_role_fixture()
      update_attrs = %{}

      assert {:ok, %UserRole{} = user_role} = UserRoles.update_user_role(user_role, update_attrs)
    end

    test "update_user_role/2 with invalid data returns error changeset" do
      user_role = user_role_fixture()
      assert {:error, %Ecto.Changeset{}} = UserRoles.update_user_role(user_role, @invalid_attrs)
      assert user_role == UserRoles.get_user_role!(user_role.id)
    end

    test "delete_user_role/1 deletes the user_role" do
      user_role = user_role_fixture()
      assert {:ok, %UserRole{}} = UserRoles.delete_user_role(user_role)
      assert_raise Ecto.NoResultsError, fn -> UserRoles.get_user_role!(user_role.id) end
    end

    test "change_user_role/1 returns a user_role changeset" do
      user_role = user_role_fixture()
      assert %Ecto.Changeset{} = UserRoles.change_user_role(user_role)
    end
  end
end
