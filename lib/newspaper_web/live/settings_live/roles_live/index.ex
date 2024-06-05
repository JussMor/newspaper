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
        </:actions>
      </.header>
    </div>



  <div class="ml-6 sm:mx-6 mt-11 grid grid-cols-1 grid-rows-1 grid-flow-row-dense gap-6">
      <.table
        id="roles"
        rows={@streams.roles}
        row_click={fn {_id, role} -> JS.navigate(~p"/settings/roles/#{role}") end}
      >
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


    <.modal
      :if={@live_action in [:new, :edit]}
      id="roles-modal"
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
    </.modal>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    roles = Roles.list_roles()
    IO.inspect(roles)
    {:ok, stream(socket, :roles, roles)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
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

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    role = Roles.get_role!(id)
    {:ok, _} = Roles.delete_role(role)

    {:noreply, stream_delete(socket, :roles, role)}
  end
end
