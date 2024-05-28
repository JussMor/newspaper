defmodule Newspaper.Contents.Article do
  use Ecto.Schema
  import Ecto.Changeset

  schema "articles" do
    field :title, :string
    field :content, :string
    
    belongs_to :user, Newspaper.Accounts.User
    belongs_to :category, Newspaper.Categories.Category
    has_one :seo, Newspaper.Seos.Seo

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(article, attrs) do
    article
    |> cast(attrs, [:title, :content, :user_id, :category_id])
    |> validate_required([:title, :content, :user_id, :category_id])
  end
end
