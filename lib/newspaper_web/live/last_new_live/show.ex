defmodule NewspaperWeb.LastNewLive.Show do
  use NewspaperWeb, :live_view

  alias Newspaper.LastNews

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:last_new, LastNews.get_last_new!(id))}
  end

  defp page_title(:show), do: "Show Last new"
  defp page_title(:edit), do: "Edit Last new"
end
