defmodule Newspaper.LastNews.LastNew do
  use Ecto.Schema
  import Ecto.Changeset

  schema "lasnews" do
    field :resume, :string
    field :cover, :string
    field :url, :string
    field :created_at, :date
    field :title_feed, :string
    field :title_excerpt, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(last_new, attrs) do
    last_new
    |> cast(attrs, [:url, :cover, :created_at,  :title_feed, :title_excerpt, :resume])
    |> validate_required([:url, :cover, :created_at, :title_feed, :title_excerpt, :resume])
  end
end
