defmodule NewspaperWeb.ChampionController do
  use NewspaperWeb, :controller

  alias Newspaper.Champions
  alias Newspaper.Champions.Champion

  def index(conn, _params) do
    champions = Champions.list_champions()
    render(conn, :index, champions: champions)
  end

  def new(conn, _params) do
    changeset = Champions.change_champion(%Champion{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"champion" => champion_params}) do
    case Champions.create_champion(champion_params) do
      {:ok, champion} ->
        conn
        |> put_flash(:info, "Champion created successfully.")
        |> redirect(to: ~p"/champions/#{champion}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    champion = Champions.get_champion!(id)
    render(conn, :show, champion: champion)
  end

  def edit(conn, %{"id" => id}) do
    champion = Champions.get_champion!(id)
    changeset = Champions.change_champion(champion)
    render(conn, :edit, champion: champion, changeset: changeset)
  end

  def update(conn, %{"id" => id, "champion" => champion_params}) do
    champion = Champions.get_champion!(id)

    case Champions.update_champion(champion, champion_params) do
      {:ok, champion} ->
        conn
        |> put_flash(:info, "Champion updated successfully.")
        |> redirect(to: ~p"/champions/#{champion}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, champion: champion, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    champion = Champions.get_champion!(id)
    {:ok, _champion} = Champions.delete_champion(champion)

    conn
    |> put_flash(:info, "Champion deleted successfully.")
    |> redirect(to: ~p"/champions")
  end
end
