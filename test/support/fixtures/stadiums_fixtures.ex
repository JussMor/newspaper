defmodule Newspaper.StadiumsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Newspaper.Stadiums` context.
  """

  @doc """
  Generate a stadium.
  """
  def stadium_fixture(attrs \\ %{}) do
    {:ok, stadium} =
      attrs
      |> Enum.into(%{
        city: "some city",
        name: "some name"
      })
      |> Newspaper.Stadiums.create_stadium()

    stadium
  end
end
