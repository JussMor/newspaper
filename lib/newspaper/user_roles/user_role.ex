defmodule Newspaper.UserRoles.UserRole do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_roles" do

    belongs_to :user, Newspaper.Accounts.User
    belongs_to :role, Newspaper.Roles.Role

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user_role, attrs) do
    user_role
    |> cast(attrs, [:user_id, :role_id])
    |> validate_required([:user_id, :role_id])
  end
end
