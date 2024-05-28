defmodule Newspaper.PermissionsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Newspaper.Permissions` context.
  """

  @doc """
  Generate a permission.
  """
  def permission_fixture(attrs \\ %{}) do
    {:ok, permission} =
      attrs
      |> Enum.into(%{
        description: "some description",
        name: "some name"
      })
      |> Newspaper.Permissions.create_permission()

    permission
  end
end
