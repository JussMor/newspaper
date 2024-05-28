defmodule Newspaper.SeosTest do
  use Newspaper.DataCase

  alias Newspaper.Seos

  describe "seos" do
    alias Newspaper.Seos.Seo

    import Newspaper.SeosFixtures

    @invalid_attrs %{description: nil, title: nil, keywords: nil}

    test "list_seos/0 returns all seos" do
      seo = seo_fixture()
      assert Seos.list_seos() == [seo]
    end

    test "get_seo!/1 returns the seo with given id" do
      seo = seo_fixture()
      assert Seos.get_seo!(seo.id) == seo
    end

    test "create_seo/1 with valid data creates a seo" do
      valid_attrs = %{description: "some description", title: "some title", keywords: "some keywords"}

      assert {:ok, %Seo{} = seo} = Seos.create_seo(valid_attrs)
      assert seo.description == "some description"
      assert seo.title == "some title"
      assert seo.keywords == "some keywords"
    end

    test "create_seo/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Seos.create_seo(@invalid_attrs)
    end

    test "update_seo/2 with valid data updates the seo" do
      seo = seo_fixture()
      update_attrs = %{description: "some updated description", title: "some updated title", keywords: "some updated keywords"}

      assert {:ok, %Seo{} = seo} = Seos.update_seo(seo, update_attrs)
      assert seo.description == "some updated description"
      assert seo.title == "some updated title"
      assert seo.keywords == "some updated keywords"
    end

    test "update_seo/2 with invalid data returns error changeset" do
      seo = seo_fixture()
      assert {:error, %Ecto.Changeset{}} = Seos.update_seo(seo, @invalid_attrs)
      assert seo == Seos.get_seo!(seo.id)
    end

    test "delete_seo/1 deletes the seo" do
      seo = seo_fixture()
      assert {:ok, %Seo{}} = Seos.delete_seo(seo)
      assert_raise Ecto.NoResultsError, fn -> Seos.get_seo!(seo.id) end
    end

    test "change_seo/1 returns a seo changeset" do
      seo = seo_fixture()
      assert %Ecto.Changeset{} = Seos.change_seo(seo)
    end
  end
end
