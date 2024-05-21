defmodule NewspaperWeb.StadiumLive.Index do
  use NewspaperWeb, :live_view

  alias Newspaper.Stadiums
  alias Newspaper.Stadiums.Stadium

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :stadiums, Stadiums.list_stadiums())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Stadium")
    |> assign(:stadium, Stadiums.get_stadium!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Stadium")
    |> assign(:stadium, %Stadium{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Stadiums")
    |> assign(:stadium, nil)
  end

  @impl true
  def handle_info({NewspaperWeb.StadiumLive.FormComponent, {:saved, stadium}}, socket) do
    {:noreply, stream_insert(socket, :stadiums, stadium)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    stadium = Stadiums.get_stadium!(id)
    {:ok, _} = Stadiums.delete_stadium(stadium)

    {:noreply, stream_delete(socket, :stadiums, stadium)}
  end
end
