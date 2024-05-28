defmodule Newspaper.RolPermissionsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Newspaper.RolPermissions` context.
  """

  @doc """
  Generate a rol_permission.
  """
  def rol_permission_fixture(attrs \\ %{}) do
    {:ok, rol_permission} =
      attrs
      |> Enum.into(%{

      })
      |> Newspaper.RolPermissions.create_rol_permission()

    rol_permission
  end
end
