defmodule Newspaper.Seos do
  @moduledoc """
  The Seos context.
  """

  import Ecto.Query, warn: false
  alias Newspaper.Repo

  alias Newspaper.Seos.Seo

  @doc """
  Returns the list of seos.

  ## Examples

      iex> list_seos()
      [%Seo{}, ...]

  """
  def list_seos do
    Repo.all(Seo)
  end

  @doc """
  Gets a single seo.

  Raises `Ecto.NoResultsError` if the Seo does not exist.

  ## Examples

      iex> get_seo!(123)
      %Seo{}

      iex> get_seo!(456)
      ** (Ecto.NoResultsError)

  """
  def get_seo!(id), do: Repo.get!(Seo, id)

  @doc """
  Creates a seo.

  ## Examples

      iex> create_seo(%{field: value})
      {:ok, %Seo{}}

      iex> create_seo(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_seo(attrs \\ %{}) do
    %Seo{}
    |> Seo.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a seo.

  ## Examples

      iex> update_seo(seo, %{field: new_value})
      {:ok, %Seo{}}

      iex> update_seo(seo, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_seo(%Seo{} = seo, attrs) do
    seo
    |> Seo.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a seo.

  ## Examples

      iex> delete_seo(seo)
      {:ok, %Seo{}}

      iex> delete_seo(seo)
      {:error, %Ecto.Changeset{}}

  """
  def delete_seo(%Seo{} = seo) do
    Repo.delete(seo)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking seo changes.

  ## Examples

      iex> change_seo(seo)
      %Ecto.Changeset{data: %Seo{}}

  """
  def change_seo(%Seo{} = seo, attrs \\ %{}) do
    Seo.changeset(seo, attrs)
  end
end
