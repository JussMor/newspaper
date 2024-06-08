defmodule NewspaperWeb.RolesLive.Index do
  use NewspaperWeb, :live_view

  alias Newspaper.Roles.Role
  alias Newspaper.Roles

  @impl true
  def render(assigns) do
    ~H"""
    <div class='px-4 pt-4'>
      <.header>
        Listing Roles
        <:actions>
          <.link patch={~p"/settings/roles/new"}>
            <.button>New Role</.button>
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

    <% check_all_html = ~s(<input type="checkbox" name="toggle-all" id="toggle-all" phx-click="toggle-all" phx-update="ignore" />) %>

    <div class="ml-6 sm:mx-6 mt-11 grid grid-cols-1 grid-rows-1 grid-flow-row-dense gap-6">
      <.table
        id="roles"
        rows={@streams.roles}
        row_click={fn {_id, role} -> JS.navigate(~p"/settings/roles/#{role}") end}
      >
        <:col :let={{_id, role}} label={raw(check_all_html)}>
         <% checked = if (role.id in @toggle_ids), do: true, else: false %>
            <% IO.inspect( @toggle_ids)%>
          <input type="checkbox" name="toggle"
            phx-click="toggle" phx-value-toggle-id={role.id} checked={checked} />

        </:col>
        <:col :let={{_id, role}} label="Role"><%= role.name %></:col>
        <:col :let={{_id, role}} label="Description"><%= role.description %></:col>
        <:action :let={{_id, role}}>
          <div class="sr-only">
            <.link navigate={~p"/settings/roles/#{role}"}>Show</.link>
          </div>
          <.link patch={~p"/settings/roles/#{role}/edit"}>Edit</.link>
        </:action>
        <:action :let={{id, role}}>
          <.link
            phx-click={JS.push("delete", value: %{id: role.id}) |> hide("##{id}")}
            data-confirm="Are you sure?"
          >
            Delete
          </.link>
        </:action>
      </.table>
    </div>

    <.offcanvas title="Listing Roles" subtitle="List of roles" id="roles-offcanvas"
      :if={@live_action in [:new, :edit]} show on_cancel={JS.patch(~p"/settings/roles")}>
      <.live_component
        module={NewspaperWeb.RolesLive.FormComponent}
        id={@role.id || :new}
        title={@page_title}
        action={@live_action}
        role={@role}
        patch={~p"/settings/roles"}
      />
    </.offcanvas>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do

    {:noreply,
      socket
      |> apply_action(socket.assigns.live_action, params)
      |> stream(:roles, list_roles())
      |> assign(:toggle_ids, [])
      |> assign(:all_roles, list_roles())
    }
  end


  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Role")
    |> assign(:role, %Role{})
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Role")
    |> assign(:role, Roles.get_role!(id))
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Roles")
    |> assign(:role, nil)
  end

  @impl true
  def handle_info({NewspaperWeb.RolesLive.FormComponent, {:saved, role}}, socket) do
    {:noreply, stream_insert(socket, :roles, role)}
  end



  def handle_event("toggle-all", %{"value" => "on"}, socket) do
    roles_ids = socket.assigns.all_roles |> Enum.map(& &1.id)

    {:noreply,
      socket
        |> stream(:roles, list_roles())
        |> assign(:toggle_ids, roles_ids)}
  end

  def handle_event("toggle-all", %{}, socket) do
      {:noreply,
      socket
        |> stream(:roles, list_roles())
        |> assign(:toggle_ids, [])}
  end



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
        role = Roles.get_role!(id)
        {:ok, _} = Roles.delete_role(role)
        stream_delete(acc, :roles, role)
      end)

    {:noreply, assign(socket, toggle_ids: [])
         |> put_flash(:info, "Selected roles deleted successfully.")}
  end


  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    role = Roles.get_role!(id)
    {:ok, _} = Roles.delete_role(role)

    {:noreply, stream_delete(socket, :roles, role)
               |> put_flash(:info, "Role deleted successfully.")}
  end


  defp list_roles() do
    Roles.list_roles()
  end
end
