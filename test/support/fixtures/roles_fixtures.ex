defmodule Newspaper.RolesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Newspaper.Roles` context.
  """

  @doc """
  Generate a role.
  """
  def role_fixture(attrs \\ %{}) do
    {:ok, role} =
      attrs
      |> Enum.into(%{
        description: "some description",
        name: "some name"
      })
      |> Newspaper.Roles.create_role()

    role
  end
end
