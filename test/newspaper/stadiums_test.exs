defmodule Newspaper.StadiumsTest do
  use Newspaper.DataCase

  alias Newspaper.Stadiums

  describe "stadiums" do
    alias Newspaper.Stadiums.Stadium

    import Newspaper.StadiumsFixtures

    @invalid_attrs %{name: nil, city: nil}

    test "list_stadiums/0 returns all stadiums" do
      stadium = stadium_fixture()
      assert Stadiums.list_stadiums() == [stadium]
    end

    test "get_stadium!/1 returns the stadium with given id" do
      stadium = stadium_fixture()
      assert Stadiums.get_stadium!(stadium.id) == stadium
    end

    test "create_stadium/1 with valid data creates a stadium" do
      valid_attrs = %{name: "some name", city: "some city"}

      assert {:ok, %Stadium{} = stadium} = Stadiums.create_stadium(valid_attrs)
      assert stadium.name == "some name"
      assert stadium.city == "some city"
    end

    test "create_stadium/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Stadiums.create_stadium(@invalid_attrs)
    end

    test "update_stadium/2 with valid data updates the stadium" do
      stadium = stadium_fixture()
      update_attrs = %{name: "some updated name", city: "some updated city"}

      assert {:ok, %Stadium{} = stadium} = Stadiums.update_stadium(stadium, update_attrs)
      assert stadium.name == "some updated name"
      assert stadium.city == "some updated city"
    end

    test "update_stadium/2 with invalid data returns error changeset" do
      stadium = stadium_fixture()
      assert {:error, %Ecto.Changeset{}} = Stadiums.update_stadium(stadium, @invalid_attrs)
      assert stadium == Stadiums.get_stadium!(stadium.id)
    end

    test "delete_stadium/1 deletes the stadium" do
      stadium = stadium_fixture()
      assert {:ok, %Stadium{}} = Stadiums.delete_stadium(stadium)
      assert_raise Ecto.NoResultsError, fn -> Stadiums.get_stadium!(stadium.id) end
    end

    test "change_stadium/1 returns a stadium changeset" do
      stadium = stadium_fixture()
      assert %Ecto.Changeset{} = Stadiums.change_stadium(stadium)
    end
  end
end
