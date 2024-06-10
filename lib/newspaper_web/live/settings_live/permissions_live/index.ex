defmodule NewspaperWeb.PermissionsLive.Index do
  use NewspaperWeb, :live_view

  alias Newspaper.PermissionCategories
  alias Newspaper.PermissionCategories.PermissionCategory

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <div class='px-6 pt-6'>
        <.header>
          Listing Permissions
          <:actions>
            <.link patch={~p"/settings/permissions/new"}>
              <.button>New Permissions</.button>
            </.link>
            <.button phx-click="delete_selected" phx-disable-with="Deleting...">Delete Selected</.button>
          </:actions>
        </.header>

        <%= if @flash do %>
          <div class="flash-message">
            <%= live_flash(@flash, :info) %>
          </div>
        <% end %>
      </div>
      <div class="ml-6 sm:mx-6 mt-11 grid grid-cols-1 grid-rows-1 grid-flow-row-dense gap-6">
        <div class="overflow-x-auto bg-white shadow">
          <table class="min-w-full">
            <thead class="text-sm text-left leading-6 text-zinc-500">
              <tr>
                <th class="py-4 px-6 font-normal "></th>
                <th class="py-4 px-6 font-normal "><%= gettext("Category") %></th>
                <th class="py-4 px-6 font-normal "><%= gettext("Permissions") %></th>
                <th class="relative p-0 pb-4">
                  <span class="sr-only"><%= gettext("Actions") %></span>
                </th>
              </tr>
            </thead>
            <tbody class='relative divide-y divide-zinc-100 border-t border-zinc-200 text-sm leading-6 text-zinc-700'>
              <%= for {id, category} <- @streams.permissions_categories do %>
                <tr id={id} class="group hover:bg-zinc-50">
                  <td class=' py-4 px-6'>
                    <input type="checkbox" name="toggle-all" id="toggle-all" phx-click="toggle-all" phx-update="ignore" />
                  </td>
                  <td class="w-1/3 relative">
                    <div class="block py-4 px-6">
                      <span><%= category.category %></span>
                    </div>
                  </td>
                  <td class="grid grid-cols-3 gap-3 py-4 px-6 w-[40rem] lg:w-full">
                    <%= for permission <- category.permissions do %>
                      <div class="text-left text-sm font-medium" id={"permission-#{permission.id}"}>
                        <li class="list-none"><%= permission.name %></li>
                      </div>
                    <% end %>
                  </td>
                </tr>
              <% end %>
            </tbody>
          </table>
        </div>
      </div>
      <.offcanvas title="Listing Roles" subtitle="List of roles" id="roles-offcanvas"
        :if={@live_action in [:new, :edit]} show on_cancel={JS.patch(~p"/settings/permissions")}>
        <.live_component
          module={NewspaperWeb.PermissionsLive.FormComponent}
          id={@permission_category.id || :new}
          title={@page_title}
          action={@live_action}
          permission_category={@permission_category}
          patch={~p"/settings/permissions"}
        />
      </.offcanvas>
    </div>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    socket =
      socket
      |> stream(:permissions_categories, list_category_permissions())
      |> apply_action(socket.assigns.live_action, params)

    {:noreply, socket}
  end

  defp apply_action(socket, :new, _params) do
    IO.inspect(socket)
    socket
    |> assign(:page_title, "New Category Permission")
    |> assign(:permission_category, %PermissionCategory{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Category Permission")
    |> assign(:permission_category, nil)
  end

  defp list_category_permissions do
    PermissionCategories.get_categorized_permissions()
  end
end
