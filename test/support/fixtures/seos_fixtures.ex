defmodule Newspaper.SeosFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Newspaper.Seos` context.
  """

  @doc """
  Generate a seo.
  """
  def seo_fixture(attrs \\ %{}) do
    {:ok, seo} =
      attrs
      |> Enum.into(%{
        description: "some description",
        keywords: "some keywords",
        title: "some title"
      })
      |> Newspaper.Seos.create_seo()

    seo
  end
end
