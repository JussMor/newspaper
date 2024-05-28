defmodule Newspaper.ContentsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Newspaper.Contents` context.
  """

  @doc """
  Generate a article.
  """
  def article_fixture(attrs \\ %{}) do
    {:ok, article} =
      attrs
      |> Enum.into(%{
        content: "some content",
        title: "some title"
      })
      |> Newspaper.Contents.create_article()

    article
  end
end
