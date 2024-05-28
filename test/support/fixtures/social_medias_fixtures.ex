defmodule Newspaper.SocialMediasFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Newspaper.SocialMedias` context.
  """

  @doc """
  Generate a social_media.
  """
  def social_media_fixture(attrs \\ %{}) do
    {:ok, social_media} =
      attrs
      |> Enum.into(%{
        platform: "some platform",
        url: "some url"
      })
      |> Newspaper.SocialMedias.create_social_media()

    social_media
  end
end
