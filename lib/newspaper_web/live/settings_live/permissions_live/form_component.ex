defmodule NewspaperWeb.PermissionsLive.FormComponent do
  use NewspaperWeb, :live_component

  alias Newspaper.PermissionCategories

    @impl true
  def render(assigns) do
    ~H"""
      <div>
        <.header>
          <%= @title %>
          <:subtitle>Use this form to manage last_new records in your database.</:subtitle>
        </.header>

        <.simple_form
          for={@form}
          id="roles_new-form"
          phx-target={@myself}
          phx-change="validate"
          phx-submit="save"
        >
          <.input field={@form[:name]} type="text" label="Name" />
          <.input field={@form[:description]} type="text" label="Description" />
          <:actions>
            <.button phx-disable-with="Saving...">Save Last new</.button>
          </:actions>
        </.simple_form>

        <div class='mt-6'>
            <h4 class='pb-4'>You're going to create the next permission set:</h4>
            <div class='bg-gray-2 rounded p-4'>
              <%= for permissionActions <- ["insert_", "publish_", "read_", "update_", "delete_"] do %>
                <div>
                  <p> <%= permissionActions %><%= @current_name %> </p>
                </div>
              <% end %>
            </div>
        </div>
      </div>
    """
  end

  @impl true
  def update(%{permission_category:  permission_category} = assigns, socket) do
    changeset = PermissionCategories.change_permission_category(permission_category)

   {:ok,
     socket
     |> assign(assigns)
     |> assign(:current_name, "")
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"permission_category" => permission_category_new_params}, socket) do

    changeset =
      socket.assigns.permission_category
      |> PermissionCategories.change_permission_category(permission_category_new_params)
      |> Map.put(:action, :validate)

      IO.inspect(changeset)
    current_name = permission_category_new_params["name"] || ""

    {:noreply,
    socket
       |> assign_form(changeset)
       |> assign(:current_name, current_name) }
  end

  def handle_event("save", %{"permission_category" => permission_category_new_params}, socket) do
    save_permission_category(socket, socket.assigns.action, permission_category_new_params)
  end

defp save_permission_category(socket, :new, permission_category_new_params) do
  case PermissionCategories.create_category_with_permissions(permission_category_new_params) do
    {:ok, permission_category, inserted_permissions} ->
      # Log the successful creation
      IO.puts("Permission category created successfully: #{inspect(permission_category)}")
      IO.puts("Inserted permissions: #{inspect(inserted_permissions)}")

      {:noreply,
        socket
        |> put_flash(:info, "Permission category created successfully")
        |> push_patch(to: socket.assigns.patch)
      }

        {:noreply,
        socket
        |> put_flash(:info, "Permission category created successfully")
        |> push_patch(to: socket.assigns.patch)
      }

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end


  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end


  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})

end
