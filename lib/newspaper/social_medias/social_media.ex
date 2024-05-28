defmodule Newspaper.SocialMedias.SocialMedia do
  use Ecto.Schema
  import Ecto.Changeset

  schema "social_medias" do
    field :url, :string
    field :platform, :string
    
    belongs_to :user, Newspaper.Accounts.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(social_media, attrs) do
    social_media
    |> cast(attrs, [:platform, :url, :user_id])
    |> validate_required([:platform, :url, :user_id])
  end
end
