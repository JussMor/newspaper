defmodule Newspaper.Repo.Migrations.CreateStadiums do
  use Ecto.Migration

  def change do
    create table(:stadiums) do
      add :name, :string
      add :city, :string

      timestamps(type: :utc_datetime)
    end
  end
end
