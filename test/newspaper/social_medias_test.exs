defmodule Newspaper.SocialMediasTest do
  use Newspaper.DataCase

  alias Newspaper.SocialMedias

  describe "social_medias" do
    alias Newspaper.SocialMedias.SocialMedia

    import Newspaper.SocialMediasFixtures

    @invalid_attrs %{url: nil, platform: nil}

    test "list_social_medias/0 returns all social_medias" do
      social_media = social_media_fixture()
      assert SocialMedias.list_social_medias() == [social_media]
    end

    test "get_social_media!/1 returns the social_media with given id" do
      social_media = social_media_fixture()
      assert SocialMedias.get_social_media!(social_media.id) == social_media
    end

    test "create_social_media/1 with valid data creates a social_media" do
      valid_attrs = %{url: "some url", platform: "some platform"}

      assert {:ok, %SocialMedia{} = social_media} = SocialMedias.create_social_media(valid_attrs)
      assert social_media.url == "some url"
      assert social_media.platform == "some platform"
    end

    test "create_social_media/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = SocialMedias.create_social_media(@invalid_attrs)
    end

    test "update_social_media/2 with valid data updates the social_media" do
      social_media = social_media_fixture()
      update_attrs = %{url: "some updated url", platform: "some updated platform"}

      assert {:ok, %SocialMedia{} = social_media} = SocialMedias.update_social_media(social_media, update_attrs)
      assert social_media.url == "some updated url"
      assert social_media.platform == "some updated platform"
    end

    test "update_social_media/2 with invalid data returns error changeset" do
      social_media = social_media_fixture()
      assert {:error, %Ecto.Changeset{}} = SocialMedias.update_social_media(social_media, @invalid_attrs)
      assert social_media == SocialMedias.get_social_media!(social_media.id)
    end

    test "delete_social_media/1 deletes the social_media" do
      social_media = social_media_fixture()
      assert {:ok, %SocialMedia{}} = SocialMedias.delete_social_media(social_media)
      assert_raise Ecto.NoResultsError, fn -> SocialMedias.get_social_media!(social_media.id) end
    end

    test "change_social_media/1 returns a social_media changeset" do
      social_media = social_media_fixture()
      assert %Ecto.Changeset{} = SocialMedias.change_social_media(social_media)
    end
  end
end
