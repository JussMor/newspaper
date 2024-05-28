defmodule Newspaper.UserRolesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Newspaper.UserRoles` context.
  """

  @doc """
  Generate a user_role.
  """
  def user_role_fixture(attrs \\ %{}) do
    {:ok, user_role} =
      attrs
      |> Enum.into(%{

      })
      |> Newspaper.UserRoles.create_user_role()

    user_role
  end
end
