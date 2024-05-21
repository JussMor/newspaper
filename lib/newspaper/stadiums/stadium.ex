defmodule Newspaper.Stadiums.Stadium do
  use Ecto.Schema
  import Ecto.Changeset

  schema "stadiums" do
    field :name, :string
    field :city, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(stadium, attrs) do
    stadium
    |> cast(attrs, [:name, :city])
    |> validate_required([:name, :city])
  end
end
