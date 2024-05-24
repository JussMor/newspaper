defmodule Newspaper.LastNewsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Newspaper.LastNews` context.
  """

  @doc """
  Generate a last_new.
  """
  def last_new_fixture(attrs \\ %{}) do
    {:ok, last_new} =
      attrs
      |> Enum.into(%{
        cover: "some cover",
        created_at: ~D[2024-05-22],
        resume: "some resume",
        title_excerpt: "some title_excerpt",
        title_feed: "some title_feed",
        url: "some url"
      })
      |> Newspaper.LastNews.create_last_new()

    last_new
  end
end
