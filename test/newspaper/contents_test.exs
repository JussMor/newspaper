defmodule Newspaper.ContentsTest do
  use Newspaper.DataCase

  alias Newspaper.Contents

  describe "articles" do
    alias Newspaper.Contents.Article

    import Newspaper.ContentsFixtures

    @invalid_attrs %{title: nil, content: nil}

    test "list_articles/0 returns all articles" do
      article = article_fixture()
      assert Contents.list_articles() == [article]
    end

    test "get_article!/1 returns the article with given id" do
      article = article_fixture()
      assert Contents.get_article!(article.id) == article
    end

    test "create_article/1 with valid data creates a article" do
      valid_attrs = %{title: "some title", content: "some content"}

      assert {:ok, %Article{} = article} = Contents.create_article(valid_attrs)
      assert article.title == "some title"
      assert article.content == "some content"
    end

    test "create_article/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Contents.create_article(@invalid_attrs)
    end

    test "update_article/2 with valid data updates the article" do
      article = article_fixture()
      update_attrs = %{title: "some updated title", content: "some updated content"}

      assert {:ok, %Article{} = article} = Contents.update_article(article, update_attrs)
      assert article.title == "some updated title"
      assert article.content == "some updated content"
    end

    test "update_article/2 with invalid data returns error changeset" do
      article = article_fixture()
      assert {:error, %Ecto.Changeset{}} = Contents.update_article(article, @invalid_attrs)
      assert article == Contents.get_article!(article.id)
    end

    test "delete_article/1 deletes the article" do
      article = article_fixture()
      assert {:ok, %Article{}} = Contents.delete_article(article)
      assert_raise Ecto.NoResultsError, fn -> Contents.get_article!(article.id) end
    end

    test "change_article/1 returns a article changeset" do
      article = article_fixture()
      assert %Ecto.Changeset{} = Contents.change_article(article)
    end
  end
end
