defmodule NewspaperWeb.LastNewLiveTest do
  use NewspaperWeb.ConnCase

  import Phoenix.LiveViewTest
  import Newspaper.LastNewsFixtures

  @create_attrs %{resume: "some resume", cover: "some cover", url: "some url", created_at: "2024-05-22", title_feed: "some title_feed", title_excerpt: "some title_excerpt"}
  @update_attrs %{resume: "some updated resume", cover: "some updated cover", url: "some updated url", created_at: "2024-05-23", title_feed: "some updated title_feed", title_excerpt: "some updated title_excerpt"}
  @invalid_attrs %{resume: nil, cover: nil, url: nil, created_at: nil, title_feed: nil, title_excerpt: nil}

  defp create_last_new(_) do
    last_new = last_new_fixture()
    %{last_new: last_new}
  end

  describe "Index" do
    setup [:create_last_new]

    test "lists all lasnews", %{conn: conn, last_new: last_new} do
      {:ok, _index_live, html} = live(conn, ~p"/lasnews")

      assert html =~ "Listing Lasnews"
      assert html =~ last_new.resume
    end

    test "saves new last_new", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/lasnews")

      assert index_live |> element("a", "New Last new") |> render_click() =~
               "New Last new"

      assert_patch(index_live, ~p"/lasnews/new")

      assert index_live
             |> form("#last_new-form", last_new: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#last_new-form", last_new: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/lasnews")

      html = render(index_live)
      assert html =~ "Last new created successfully"
      assert html =~ "some resume"
    end

    test "updates last_new in listing", %{conn: conn, last_new: last_new} do
      {:ok, index_live, _html} = live(conn, ~p"/lasnews")

      assert index_live |> element("#lasnews-#{last_new.id} a", "Edit") |> render_click() =~
               "Edit Last new"

      assert_patch(index_live, ~p"/lasnews/#{last_new}/edit")

      assert index_live
             |> form("#last_new-form", last_new: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#last_new-form", last_new: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/lasnews")

      html = render(index_live)
      assert html =~ "Last new updated successfully"
      assert html =~ "some updated resume"
    end

    test "deletes last_new in listing", %{conn: conn, last_new: last_new} do
      {:ok, index_live, _html} = live(conn, ~p"/lasnews")

      assert index_live |> element("#lasnews-#{last_new.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#lasnews-#{last_new.id}")
    end
  end

  describe "Show" do
    setup [:create_last_new]

    test "displays last_new", %{conn: conn, last_new: last_new} do
      {:ok, _show_live, html} = live(conn, ~p"/lasnews/#{last_new}")

      assert html =~ "Show Last new"
      assert html =~ last_new.resume
    end

    test "updates last_new within modal", %{conn: conn, last_new: last_new} do
      {:ok, show_live, _html} = live(conn, ~p"/lasnews/#{last_new}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Last new"

      assert_patch(show_live, ~p"/lasnews/#{last_new}/show/edit")

      assert show_live
             |> form("#last_new-form", last_new: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#last_new-form", last_new: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/lasnews/#{last_new}")

      html = render(show_live)
      assert html =~ "Last new updated successfully"
      assert html =~ "some updated resume"
    end
  end
end
