defmodule Newspaper.LastNewsTest do
  use Newspaper.DataCase

  alias Newspaper.LastNews

  describe "lasnews" do
    alias Newspaper.LastNews.LastNew

    import Newspaper.LastNewsFixtures

    @invalid_attrs %{resume: nil, cover: nil, url: nil, created_at: nil, title_feed: nil, title_excerpt: nil}

    test "list_lasnews/0 returns all lasnews" do
      last_new = last_new_fixture()
      assert LastNews.list_lasnews() == [last_new]
    end

    test "get_last_new!/1 returns the last_new with given id" do
      last_new = last_new_fixture()
      assert LastNews.get_last_new!(last_new.id) == last_new
    end

    test "create_last_new/1 with valid data creates a last_new" do
      valid_attrs = %{resume: "some resume", cover: "some cover", url: "some url", created_at: ~D[2024-05-22], title_feed: "some title_feed", title_excerpt: "some title_excerpt"}

      assert {:ok, %LastNew{} = last_new} = LastNews.create_last_new(valid_attrs)
      assert last_new.resume == "some resume"
      assert last_new.cover == "some cover"
      assert last_new.url == "some url"
      assert last_new.created_at == ~D[2024-05-22]
      assert last_new.title_feed == "some title_feed"
      assert last_new.title_excerpt == "some title_excerpt"
    end

    test "create_last_new/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = LastNews.create_last_new(@invalid_attrs)
    end

    test "update_last_new/2 with valid data updates the last_new" do
      last_new = last_new_fixture()
      update_attrs = %{resume: "some updated resume", cover: "some updated cover", url: "some updated url", created_at: ~D[2024-05-23], title_feed: "some updated title_feed", title_excerpt: "some updated title_excerpt"}

      assert {:ok, %LastNew{} = last_new} = LastNews.update_last_new(last_new, update_attrs)
      assert last_new.resume == "some updated resume"
      assert last_new.cover == "some updated cover"
      assert last_new.url == "some updated url"
      assert last_new.created_at == ~D[2024-05-23]
      assert last_new.title_feed == "some updated title_feed"
      assert last_new.title_excerpt == "some updated title_excerpt"
    end

    test "update_last_new/2 with invalid data returns error changeset" do
      last_new = last_new_fixture()
      assert {:error, %Ecto.Changeset{}} = LastNews.update_last_new(last_new, @invalid_attrs)
      assert last_new == LastNews.get_last_new!(last_new.id)
    end

    test "delete_last_new/1 deletes the last_new" do
      last_new = last_new_fixture()
      assert {:ok, %LastNew{}} = LastNews.delete_last_new(last_new)
      assert_raise Ecto.NoResultsError, fn -> LastNews.get_last_new!(last_new.id) end
    end

    test "change_last_new/1 returns a last_new changeset" do
      last_new = last_new_fixture()
      assert %Ecto.Changeset{} = LastNews.change_last_new(last_new)
    end
  end
end
