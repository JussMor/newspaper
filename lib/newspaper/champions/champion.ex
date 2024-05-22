defmodule Newspaper.Champions.Champion do
  use Ecto.Schema
  import Ecto.Changeset

  schema "champions" do
    field :name, :string
    field :age, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(champion, attrs) do
    champion
    |> cast(attrs, [:name, :age])
    |> validate_required([:name, :age])
  end
end
