defmodule NewspaperWeb.RolesLive.Index do
  use NewspaperWeb, :live_view

  alias Newspaper.Roles.Role
  alias Newspaper.Roles

  @impl true
  def render(assigns) do
    ~H"""

    <div>
      <.header>
        Listing Lasnews
        <:actions>
          <.link patch={~p"/settings/roles/new"}>
            <.button>New Role</.button>
          </.link>
        </:actions>
      </.header>
    </div>

    <div>
      <h1>Roles</h1>
      <ul id="roles-list" phx-update="stream">
        <%= for {id, role} <- @streams.roles do %>
          <li id={id}>
            <strong><%= role.name %></strong><br>
            <em><%= role.description %></em><br>
            <.link patch={~p"/settings/roles/#{role.id}/edit"}>Edit</.link>
            <.link
              phx-click={JS.push("delete", value: %{id: role.id}) |> hide("##{id}")}
              data-confirm="Are you sure?"
            >
              Delete
            </.link>
          </li>
        <% end %>
      </ul>
    </div>

    <.modal :if={@live_action in [:new, :edit]} id="roles-modal" show on_cancel={JS.patch(~p"/settings/roles")}>
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
