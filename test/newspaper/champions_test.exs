defmodule Newspaper.ChampionsTest do
  use Newspaper.DataCase

  alias Newspaper.Champions

  describe "champions" do
    alias Newspaper.Champions.Champion

    import Newspaper.ChampionsFixtures

    @invalid_attrs %{name: nil, age: nil}

    test "list_champions/0 returns all champions" do
      champion = champion_fixture()
      assert Champions.list_champions() == [champion]
    end

    test "get_champion!/1 returns the champion with given id" do
      champion = champion_fixture()
      assert Champions.get_champion!(champion.id) == champion
    end

    test "create_champion/1 with valid data creates a champion" do
      valid_attrs = %{name: "some name", age: 42}

      assert {:ok, %Champion{} = champion} = Champions.create_champion(valid_attrs)
      assert champion.name == "some name"
      assert champion.age == 42
    end

    test "create_champion/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Champions.create_champion(@invalid_attrs)
    end

    test "update_champion/2 with valid data updates the champion" do
      champion = champion_fixture()
      update_attrs = %{name: "some updated name", age: 43}

      assert {:ok, %Champion{} = champion} = Champions.update_champion(champion, update_attrs)
      assert champion.name == "some updated name"
      assert champion.age == 43
    end

    test "update_champion/2 with invalid data returns error changeset" do
      champion = champion_fixture()
      assert {:error, %Ecto.Changeset{}} = Champions.update_champion(champion, @invalid_attrs)
      assert champion == Champions.get_champion!(champion.id)
    end

    test "delete_champion/1 deletes the champion" do
      champion = champion_fixture()
      assert {:ok, %Champion{}} = Champions.delete_champion(champion)
      assert_raise Ecto.NoResultsError, fn -> Champions.get_champion!(champion.id) end
    end

    test "change_champion/1 returns a champion changeset" do
      champion = champion_fixture()
      assert %Ecto.Changeset{} = Champions.change_champion(champion)
    end
  end
end
