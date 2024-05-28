defmodule Newspaper.Seos.Seo do
  use Ecto.Schema
  import Ecto.Changeset

  schema "seos" do
    field :description, :string
    field :title, :string
    field :keywords, :string
    belongs_to :article, Newspaper.Contents.Article

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(seo, attrs) do
    seo
    |> cast(attrs, [:title, :description, :keywords, :article_id])
    |> validate_required([:title, :description, :keywords, :article_id])
  end
end
