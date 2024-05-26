defmodule Newspaper.LastNews do
  @moduledoc """
  The LastNews context.
  """

  import Ecto.Query, warn: false
  alias Newspaper.Repo

  alias Newspaper.LastNews.LastNew

  @doc """
  Returns the list of lasnews.

  ## Examples

      iex> list_lasnews()
      [%LastNew{}, ...]

  """
 def list_lasnews(opts \\ [page: 1, page_size: 10]) do
    page = Keyword.get(opts, :page, 1)
    page_size = Keyword.get(opts, :page_size, 10)

    LastNew
    |> order_by([n], desc: n.inserted_at)
    |> Repo.paginate(page: page, page_size: page_size)
  end

  @doc """
  Gets a single last_new.

  Raises `Ecto.NoResultsError` if the Last new does not exist.

  ## Examples

      iex> get_last_new!(123)
      %LastNew{}

      iex> get_last_new!(456)
      ** (Ecto.NoResultsError)

  """
  def get_last_new!(id), do: Repo.get!(LastNew, id)

  @doc """
  Creates a last_new.

  ## Examples

      iex> create_last_new(%{field: value})
      {:ok, %LastNew{}}

      iex> create_last_new(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_last_new(attrs \\ %{}) do
    %LastNew{}
    |> LastNew.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a last_new.

  ## Examples

      iex> update_last_new(last_new, %{field: new_value})
      {:ok, %LastNew{}}

      iex> update_last_new(last_new, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_last_new(%LastNew{} = last_new, attrs) do
    last_new
    |> LastNew.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a last_new.

  ## Examples

      iex> delete_last_new(last_new)
      {:ok, %LastNew{}}

      iex> delete_last_new(last_new)
      {:error, %Ecto.Changeset{}}

  """
  def delete_last_new(%LastNew{} = last_new) do
    Repo.delete(last_new)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking last_new changes.

  ## Examples

      iex> change_last_new(last_new)
      %Ecto.Changeset{data: %LastNew{}}

  """
  def change_last_new(%LastNew{} = last_new, attrs \\ %{}) do
    LastNew.changeset(last_new, attrs)
  end
end
