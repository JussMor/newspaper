defmodule Newspaper.UserPermissionsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Newspaper.UserPermissions` context.
  """

  @doc """
  Generate a user_permission.
  """
  def user_permission_fixture(attrs \\ %{}) do
    {:ok, user_permission} =
      attrs
      |> Enum.into(%{

      })
      |> Newspaper.UserPermissions.create_user_permission()

    user_permission
  end
end
