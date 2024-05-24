defmodule NewspaperWeb.LastNewLive.FormComponent do
  use NewspaperWeb, :live_component

  alias Newspaper.LastNews

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
        id="last_new-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:url]} type="text" label="Url" />
        <.input field={@form[:cover]} type="text" label="Cover" />
        <.input field={@form[:created_at]} type="date" label="Created at" />
        <.input field={@form[:title_feed]} type="text" label="Title feed" />
        <.input field={@form[:title_excerpt]} type="text" label="Title excerpt" />
        <.input field={@form[:resume]} type="text" label="Resume" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Last new</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{last_new: last_new} = assigns, socket) do
    changeset = LastNews.change_last_new(last_new)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"last_new" => last_new_params}, socket) do
    changeset =
      socket.assigns.last_new
      |> LastNews.change_last_new(last_new_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"last_new" => last_new_params}, socket) do
    save_last_new(socket, socket.assigns.action, last_new_params)
  end

  defp save_last_new(socket, :edit, last_new_params) do
    case LastNews.update_last_new(socket.assigns.last_new, last_new_params) do
      {:ok, last_new} ->
        notify_parent({:saved, last_new})

        {:noreply,
         socket
         |> put_flash(:info, "Last new updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_last_new(socket, :new, last_new_params) do
    case LastNews.create_last_new(last_new_params) do
      {:ok, last_new} ->
        notify_parent({:saved, last_new})

        {:noreply,
         socket
         |> put_flash(:info, "Last new created successfully")
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
