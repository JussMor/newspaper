defmodule NewspaperWeb.ChampionControllerTest do
  use NewspaperWeb.ConnCase

  import Newspaper.ChampionsFixtures

  @create_attrs %{name: "some name", age: 42}
  @update_attrs %{name: "some updated name", age: 43}
  @invalid_attrs %{name: nil, age: nil}

  describe "index" do
    test "lists all champions", %{conn: conn} do
      conn = get(conn, ~p"/champions")
      assert html_response(conn, 200) =~ "Listing Champions"
    end
  end

  describe "new champion" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/champions/new")
      assert html_response(conn, 200) =~ "New Champion"
    end
  end

  describe "create champion" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/champions", champion: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/champions/#{id}"

      conn = get(conn, ~p"/champions/#{id}")
      assert html_response(conn, 200) =~ "Champion #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/champions", champion: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Champion"
    end
  end

  describe "edit champion" do
    setup [:create_champion]

    test "renders form for editing chosen champion", %{conn: conn, champion: champion} do
      conn = get(conn, ~p"/champions/#{champion}/edit")
      assert html_response(conn, 200) =~ "Edit Champion"
    end
  end

  describe "update champion" do
    setup [:create_champion]

    test "redirects when data is valid", %{conn: conn, champion: champion} do
      conn = put(conn, ~p"/champions/#{champion}", champion: @update_attrs)
      assert redirected_to(conn) == ~p"/champions/#{champion}"

      conn = get(conn, ~p"/champions/#{champion}")
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, champion: champion} do
      conn = put(conn, ~p"/champions/#{champion}", champion: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Champion"
    end
  end

  describe "delete champion" do
    setup [:create_champion]

    test "deletes chosen champion", %{conn: conn, champion: champion} do
      conn = delete(conn, ~p"/champions/#{champion}")
      assert redirected_to(conn) == ~p"/champions"

      assert_error_sent 404, fn ->
        get(conn, ~p"/champions/#{champion}")
      end
    end
  end

  defp create_champion(_) do
    champion = champion_fixture()
    %{champion: champion}
  end
end
