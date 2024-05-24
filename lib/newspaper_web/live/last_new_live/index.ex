defmodule NewspaperWeb.LastNewLive.Index do
  use NewspaperWeb, :live_view

  alias Newspaper.LastNews
  alias Newspaper.LastNews.LastNew

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :lasnews, LastNews.list_lasnews())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Last new")
    |> assign(:last_new, LastNews.get_last_new!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Last new")
    |> assign(:last_new, %LastNew{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Lasnews")
    |> assign(:last_new, nil)
  end

  @impl true
  def handle_info({NewspaperWeb.LastNewLive.FormComponent, {:saved, last_new}}, socket) do
    {:noreply, stream_insert(socket, :lasnews, last_new)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    last_new = LastNews.get_last_new!(id)
    {:ok, _} = LastNews.delete_last_new(last_new)

    {:noreply, stream_delete(socket, :lasnews, last_new)}
  end
end
