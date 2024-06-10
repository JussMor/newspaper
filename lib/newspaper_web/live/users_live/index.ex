defmodule NewspaperWeb.UsersLive.Index do
  use NewspaperWeb, :live_view

  alias Newspaper.Accounts
  alias Newspaper.Roles
  alias Newspaper.UserRoles
  alias Newspaper.UserRoles.UserRole

  @impl true
  def render(assigns) do
    ~H"""
    <h1>Users</h1>

    <div class='mb-8'>
      <div>
        <%= @users.id %>
      </div>
      <div>
        <%= @users.email %>
      </div>

      <div class='mt-8'>
        <%= for role <- @users.roles do %>
          <p ><%= role.name %></p>
        <% end %>
      </div>

      <.simple_form for={@form} phx-change="validate" phx-submit="save">
        <.input field={@form[:role_id]} label="Role" type="select" options={role_options(@roles)} />
        <:actions>
          <.button>Save</.button>
        </:actions>
      </.simple_form>
    </div>

    <%= for {id, role} <- @streams.roles do %>
      <div id={id}>
        <h3><%= role.id %></h3>
        <h2><%= role.name %></h2>
        <h3><%= role.description %></h3>
      </div>
    <% end %>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    current_user_id = socket.assigns.current_user.id
    users = Accounts.get_user!(current_user_id)
    roles = Roles.list_roles()
    changeset = UserRole.changeset(%UserRole{}, %{})



    socket =
      socket
      |> assign(:users, users)
      |> assign(:roles, roles)
      |> assign(:form, to_form(changeset))
      |> stream(:roles, roles)

    {:ok, socket}
  end

  @impl true
  def handle_event("validate", %{"user_role" => user_role_params}, socket) do
    changeset =
      %UserRole{}
      |> UserRoles.change_user_role(user_role_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  @impl true
  def handle_event("save", %{"user_role" => %{"role_id" => role_id}}, socket) do
    current_user_id = socket.assigns.current_user.id
    user_role_params = %{"user_id" => current_user_id, "role_id" => role_id}

    case UserRoles.create_user_role(user_role_params) do
      {:ok, _user_role} ->
        {:noreply,
         socket
         |> put_flash(:info, "User role created successfully")
         |> push_redirect(to:  ~p"/users")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp role_options(roles) do
    Enum.map(roles, fn role -> {role.name, role.id} end)
  end
end
