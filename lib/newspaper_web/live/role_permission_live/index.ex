defmodule NewspaperWeb.RolePermissionLive.Index do
  use NewspaperWeb, :live_view

  alias Newspaper.PermissionCategories
  alias Newspaper.Roles
  alias Newspaper.RolPermissions


  @impl true
  def render(assigns) do
    ~H"""
    <.live_component
    module={NewspaperWeb.AuthComponent}
    id={5}
    data={@current_user}
    permission_to_check={["insert_article"]}
    >
      <div>
        <h1 class='font-bold'>I can insert articles</h1>
      </div>
    </.live_component>
      <div>
        <%= for role <- @roles do %>
          <div>
            <h2><%= role.id %></h2>
            <h2><%= role.name %></h2>
            <h1>Permissions Categories</h1>
            <div phx-update="stream" id={"permissions-categories-role-#{role.id}"}>
              <%= for {id, category} <- @streams.permissions_categories do %>
                <div id={"category-#{id}-role-#{role.id}"}>
                  <h2><%= category.category %></h2>
                  <ul>
                    <%= for permission <- category.permissions do %>
                      <label>
                        <input type="checkbox" phx-click="toggle_permission" phx-value-role-id={role.id} phx-value-permission-id={permission.id} checked={permission.id in @role_permissions[role.id]} />
                        <%= permission.name %>
                      </label>
                    <% end %>
                  </ul>
                </div>
              <% end %>
            </div>
          </div>
        <% end %>
      </div>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    permissions_categories = PermissionCategories.get_categorized_permissions()
    roles = Roles.list_roles()
    role_permissions = for role <- roles, into: %{}, do: {role.id, RolPermissions.get_rol_permission!(role.id)}

    socket =
      socket
      |> assign(:roles, roles)
      |> assign(:role_permissions, role_permissions)
      |> stream(:permissions_categories, permissions_categories)

    {:ok, socket}
  end

  @impl true
  def handle_event("toggle_permission", %{"role-id" => role_id, "permission-id" => permission_id}, socket) do
    role_id = String.to_integer(role_id)
    permission_id = String.to_integer(permission_id)

    RolPermissions.toggle_role_permission(role_id, permission_id)
    role_permissions = for role <- socket.assigns.roles, into: %{}, do: {role.id, RolPermissions.get_rol_permission!(role.id)}
    {:noreply, assign(socket, :role_permissions, role_permissions)}
  end


end
