defmodule NewspaperWeb.PermissionLive.Index do
  use NewspaperWeb, :live_view

  alias Newspaper.PermissionCategories
  
  @impl true
  def render(assigns) do
    ~H"""
      <div>
        <h1>Permissions Categories</h1>
        <%= for {id, category} <- @streams.permissions_categories do %>
          <div id={id}>
            <h2><%= category.category %></h2>
            <ul>
              <%= for permission <- category.permissions do %>
                <li><%= permission.id %> - <%= permission.name %></li>
              <% end %>
            </ul>
          </div>
        <% end %>
      </div>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    permissions_categories = PermissionCategories.get_categorized_permissions()

    IO.inspect(permissions_categories)
    {:ok, stream(socket, :permissions_categories, permissions_categories)}
  end

end
