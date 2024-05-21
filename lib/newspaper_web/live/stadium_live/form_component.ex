defmodule NewspaperWeb.StadiumLive.FormComponent do
  use NewspaperWeb, :live_component

  alias Newspaper.Stadiums

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage stadium records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="stadium-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:city]} type="text" label="City" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Stadium</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{stadium: stadium} = assigns, socket) do
    changeset = Stadiums.change_stadium(stadium)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"stadium" => stadium_params}, socket) do
    changeset =
      socket.assigns.stadium
      |> Stadiums.change_stadium(stadium_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"stadium" => stadium_params}, socket) do
    save_stadium(socket, socket.assigns.action, stadium_params)
  end

  defp save_stadium(socket, :edit, stadium_params) do
    case Stadiums.update_stadium(socket.assigns.stadium, stadium_params) do
      {:ok, stadium} ->
        notify_parent({:saved, stadium})

        {:noreply,
         socket
         |> put_flash(:info, "Stadium updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_stadium(socket, :new, stadium_params) do
    case Stadiums.create_stadium(stadium_params) do
      {:ok, stadium} ->
        notify_parent({:saved, stadium})

        {:noreply,
         socket
         |> put_flash(:info, "Stadium created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
