defmodule Newspaper.RolPermissions do
  @moduledoc """
  The RolPermissions context.
  """

  import Ecto.Query, warn: false
  alias Newspaper.Repo

  alias Newspaper.RolPermissions.RolPermission

  @doc """
  Returns the list of rol_permissions.

  ## Examples

      iex> list_rol_permissions()
      [%RolPermission{}, ...]

  """
  def list_rol_permissions do
    Repo.all(RolPermission)
  end

  @doc """
  Gets a single rol_permission.

  Raises `Ecto.NoResultsError` if the Rol permission does not exist.

  ## Examples

      iex> get_rol_permission!(123)
      %RolPermission{}

      iex> get_rol_permission!(456)
      ** (Ecto.NoResultsError)

  """
  # def get_rol_permission!(id), do: Repo.get!(RolPermission, id)

  def get_rol_permission!(role_id) do
    Repo.all(from rp in RolPermission, where: rp.role_id == ^role_id, select: rp.permission_id)
  end

  def toggle_role_permission(role_id, permission_id) do
    case Repo.get_by(RolPermission, role_id: role_id, permission_id: permission_id) do
      nil ->
        %RolPermission{role_id: role_id, permission_id: permission_id}
        |> Repo.insert()
      role_permission ->
        Repo.delete(role_permission)
    end
  end

  @doc """
  Creates a rol_permission.

  ## Examples

      iex> create_rol_permission(%{field: value})
      {:ok, %RolPermission{}}

      iex> create_rol_permission(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_rol_permission(attrs \\ %{}) do
    %RolPermission{}
    |> RolPermission.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a rol_permission.

  ## Examples

      iex> update_rol_permission(rol_permission, %{field: new_value})
      {:ok, %RolPermission{}}

      iex> update_rol_permission(rol_permission, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_rol_permission(%RolPermission{} = rol_permission, attrs) do
    rol_permission
    |> RolPermission.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a rol_permission.

  ## Examples

      iex> delete_rol_permission(rol_permission)
      {:ok, %RolPermission{}}

      iex> delete_rol_permission(rol_permission)
      {:error, %Ecto.Changeset{}}

  """
  def delete_rol_permission(%RolPermission{} = rol_permission) do
    Repo.delete(rol_permission)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking rol_permission changes.

  ## Examples

      iex> change_rol_permission(rol_permission)
      %Ecto.Changeset{data: %RolPermission{}}

  """
  def change_rol_permission(%RolPermission{} = rol_permission, attrs \\ %{}) do
    RolPermission.changeset(rol_permission, attrs)
  end
end
