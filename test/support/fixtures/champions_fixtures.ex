defmodule Newspaper.ChampionsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Newspaper.Champions` context.
  """

  @doc """
  Generate a champion.
  """
  def champion_fixture(attrs \\ %{}) do
    {:ok, champion} =
      attrs
      |> Enum.into(%{
        age: 42,
        name: "some name"
      })
      |> Newspaper.Champions.create_champion()

    champion
  end
end
