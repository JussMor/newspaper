defmodule Newspaper.SocialMedias do
  @moduledoc """
  The SocialMedias context.
  """

  import Ecto.Query, warn: false
  alias Newspaper.Repo

  alias Newspaper.SocialMedias.SocialMedia

  @doc """
  Returns the list of social_medias.

  ## Examples

      iex> list_social_medias()
      [%SocialMedia{}, ...]

  """
  def list_social_medias do
    Repo.all(SocialMedia)
  end

  @doc """
  Gets a single social_media.

  Raises `Ecto.NoResultsError` if the Social media does not exist.

  ## Examples

      iex> get_social_media!(123)
      %SocialMedia{}

      iex> get_social_media!(456)
      ** (Ecto.NoResultsError)

  """
  def get_social_media!(id), do: Repo.get!(SocialMedia, id)

  @doc """
  Creates a social_media.

  ## Examples

      iex> create_social_media(%{field: value})
      {:ok, %SocialMedia{}}

      iex> create_social_media(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_social_media(attrs \\ %{}) do
    %SocialMedia{}
    |> SocialMedia.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a social_media.

  ## Examples

      iex> update_social_media(social_media, %{field: new_value})
      {:ok, %SocialMedia{}}

      iex> update_social_media(social_media, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_social_media(%SocialMedia{} = social_media, attrs) do
    social_media
    |> SocialMedia.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a social_media.

  ## Examples

      iex> delete_social_media(social_media)
      {:ok, %SocialMedia{}}

      iex> delete_social_media(social_media)
      {:error, %Ecto.Changeset{}}

  """
  def delete_social_media(%SocialMedia{} = social_media) do
    Repo.delete(social_media)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking social_media changes.

  ## Examples

      iex> change_social_media(social_media)
      %Ecto.Changeset{data: %SocialMedia{}}

  """
  def change_social_media(%SocialMedia{} = social_media, attrs \\ %{}) do
    SocialMedia.changeset(social_media, attrs)
  end
end
