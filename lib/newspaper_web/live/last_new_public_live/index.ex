defmodule NewspaperWeb.LastNewPublicLive.Index do
  use NewspaperWeb, :live_view

  alias Newspaper.LastNews
  # alias Newspaper.LastNews.LastNew

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :page_size, 9)}
  end

  @impl true
  def handle_event("paginate", %{"page" => page}, socket) do
    {:noreply, push_patch(socket, to: ~p"/ultimas-noticias?page=#{page}")}
  end

  @impl true
  def handle_params(params, _uri, socket) do

    page = Map.get(params, "page", "1")
    page_size = socket.assigns[:page_size] || 9

    pagination = LastNews.list_lasnews(page: page, page_size: page_size)

    socket =
      socket
      |> assign(:page, pagination.page_number)
      |> assign(:total_pages, pagination.total_pages)
      |> assign(:total_entries, pagination.total_entries)
      |> stream(:lastnews, pagination.entries)

    {:noreply, socket}
  end
end
