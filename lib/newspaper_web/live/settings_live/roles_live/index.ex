defmodule NewspaperWeb.RolesLive.Index do
  use NewspaperWeb, :live_view

  alias Newspaper.Roles.Role
  alias Newspaper.Roles

  @impl true
  def render(assigns) do
    ~H"""
    <div class="px-6 pt-6">
      <.header>
        Listing Roles
        <:actions>
          <.link patch={~p"/settings/roles/new"}>
            <.button>New Role</.button>
          </.link>
          <.button phx-click="delete_selected" phx-disable-with="Deleting...">
            Delete Selected
          </.button>
        </:actions>
      </.header>

      <%= if @flash do %>
        <div class="flash-message">
          <%= live_flash(@flash, :info) %>
        </div>
      <% end %>
    </div>

    <% check_all_html =
      ~s(<input class="rounded border-zinc-300 text-zinc-900 focus:ring-0" type="checkbox" name="toggle-all" id="toggle-all" phx-click="toggle-all" phx-update="ignore" />) %>

    <div class="ml-6 sm:mx-6 mt-11 grid grid-cols-1 grid-rows-1 grid-flow-row-dense gap-6 ">
      <.table
        id="roles"
        rows={@streams.roles}
        row_click={fn {_id, role} -> JS.navigate(~p"/settings/roles/#{role}") end}
      >
        <:col :let={{_id, role}} label={raw(check_all_html)}>
          <% checked = if role.id in @toggle_ids, do: true, else: false %>
          <.input
            id={"toggle-roles-#{role.id}"}
            type="checkbox"
            name="toggle"
            phx-click="toggle"
            phx-value-toggle-id={role.id}
            checked={checked}
          />
        </:col>
        <:col :let={{_id, role}} label={raw(~s(
            <div class='flex gap-2 items-end'>
                <svg
                width="13"
                height="13"
                viewBox="0 0 24 24"
                xmlns="http://www.w3.org/2000/svg">
                <circle
                  cx="12"
                  cy="7"
                  r="4"
                  stroke="#000000"
                  stroke-width="2"
                  fill="none"
                  stroke-linecap="round"
                  stroke-linejoin="round"/>
                <path
                  d="M12 14c-4.418 0-8 3.582-8 8h16c0-4.418-3.582-8-8-8z"
                  stroke="#000000"
                  stroke-width="2"
                  fill="none"
                  stroke-linecap="round"
                  stroke-linejoin="round"/>
              </svg> 
              #{sort_link("name", "Role", @sort_by, @sort_order)}
            </div>
            
            ))}><%= role.name %></:col>
        <:col
          :let={{_id, role}}
          label={raw(sort_link("description", "Description", @sort_by, @sort_order))}
        >
          <%= role.description %>
        </:col>

        <:action :let={{_id, role}}>
          <div class="sr-only">
            <.link navigate={~p"/settings/roles/#{role}"}>Show</.link>
          </div>
          <.link patch={~p"/settings/roles/#{role}/edit"}>Edit</.link>
        </:action>
      </.table>
    </div>

    <.offcanvas
      :if={@live_action in [:new, :edit]}
      title="Listing Roles"
      subtitle="List of roles"
      id="roles-offcanvas"
      show
      on_cancel={JS.patch(~p"/settings/roles")}
    >
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
  def handle_params(params, url, socket) do
    # Default sort by "name"
    sort_by = params["sort_by"] || "name"
    # Default order "asc"
    sort_order = params["sort_order"] || "asc"

    sort_opts = [
      sort_by: String.to_existing_atom(sort_by),
      sort_order: String.to_existing_atom(sort_order)
    ]

    # IO.inspect(socket)
    {:noreply,
     socket
     |> apply_action(socket.assigns.live_action, params)
     |> assign(:sort_by, sort_by)
     |> assign(:sort_order, sort_order)
     |> stream(:roles, list_roles(sort_opts))
     |> assign(:toggle_ids, [])
     |> assign(:all_roles, list_roles(sort_opts))
     |> apply_sidebar(params, url)}
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

  defp apply_sidebar(socket, params, url) do
    option = geturlPath(url, 2)
    tab = geturlPath(url, 1)

    socket
    |> assign(:active_tab, tab)
    |> assign(:active_opt, option)
  end

  def geturlPath(url, number) do
    case URI.parse(url) do
      %URI{path: path} ->
        path_parts = String.split(path, "/", trim: true)

        case Enum.at(path_parts, number - 1) do
          nil -> "Index out of bounds"
          part -> part
        end

      _ ->
        "Invalid URL"
    end
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
      if id in toggle_ids do
        Enum.reject(toggle_ids, &(&1 == id))
      else
        [id | toggle_ids]
      end

    {:noreply, assign(socket, :toggle_ids, toggle_ids)}
  end

  def handle_event("sort", %{"sort" => sort_field, "order" => sort_order}, socket) do
    socket =
      socket
      |> assign(:sort_by, sort_field)
      |> assign(:sort_order, sort_order)
      |> push_navigate(to: ~p"/settings/roles?sort_by=#{sort_field}&sort_order=#{sort_order}")

    {:noreply, socket}
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

    {:noreply,
     assign(socket, toggle_ids: [])
     |> put_flash(:info, "Selected roles deleted successfully.")}
  end

  defp list_roles(sort_opts \\ []) do
    Roles.list_roles(sort_opts)
  end

  defp sort_link(name, label, current_sort_by, current_sort_order) do
    {new_sort_order, symbol} =
      if name == current_sort_by do
        case current_sort_order do
          "asc" -> {"desc", "↓"}
          "desc" -> {"asc", "↑"}
        end
      else
        {"asc", "↑"}
      end

    ~s(<button class="flex flex-row gap-2 text-black items-end w-full" phx-click="sort" phx-value-sort="#{name}" phx-value-order="#{new_sort_order}">
        <p class='font-medium  leading-[90%]'>#{label}</p>
        <i class="font-bold not-italic leading-none ">#{symbol}</i>
    </button>)
  end
end
