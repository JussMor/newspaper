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
            <tbody
              id={"permissions-table"}
              phx-update={"stream"}
              class='relative divide-y divide-zinc-100 border-t border-zinc-200 text-sm leading-6 text-zinc-700'>
              <%= for {id, category} <- @streams.permissions_categories do %>
                <tr id={id} class="group hover:bg-zinc-50">
                  <td class=' py-4 px-6'>
                    <% checked = if (category.id in @toggle_ids), do: true, else: false %>
                        <input type="checkbox" name="toggle"
                          phx-click="toggle" phx-value-toggle-id={category.id} checked={checked} />
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
                  <td class="py-4 px-6">
                    <div class="flex items    -center space-x-2">
                      <.link patch={~p"/settings/permissions/#{category.id}/edit"} class="text-sm text-zinc-500 hover:text-zinc-700">
                        Edit
                      </.link>
                    </div>
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
      |> assign(:toggle_ids, [])

    {:noreply, socket}
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Category Permission")
    |> assign(:permission_category, %PermissionCategory{})
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    permission_category = PermissionCategories.get_permission_category!(id)

    socket
    |> assign(:page_title, "Edit Category Permission")
    |> assign(:permission_category, permission_category)
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Category Permission")
    |> assign(:permission_category, nil)
  end

  defp list_category_permissions do
    PermissionCategories.get_categorized_permissions()
  end

  @impl true
  def handle_event("toggle", %{"toggle-id" => id}, socket) do
    id = String.to_integer(id)
    toggle_ids = socket.assigns.toggle_ids

    toggle_ids =
      if (id in toggle_ids) do
        Enum.reject(toggle_ids, & &1 == id)
      else
        [id|toggle_ids]
      end

    {:noreply, assign(socket, :toggle_ids, toggle_ids)}
  end

  @impl true
  def handle_event("delete_selected", _params, socket) do
    toggle_ids = socket.assigns.toggle_ids

    socket =
      Enum.reduce(toggle_ids, socket, fn id, acc ->
        category = PermissionCategories.get_permission_category!(id)
        {:ok, _} = PermissionCategories.delete_selected_permissions(category)
        stream_delete(acc, :permissions_categories, category)
      end)

    {:noreply, assign(socket, toggle_ids: [])
         |> put_flash(:info, "Selected roles deleted successfully.")}
  end


end
