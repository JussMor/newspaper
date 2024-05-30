defmodule NewspaperWeb.AppLive.Index do
  use NewspaperWeb, :live_view

  alias Newspaper.Accounts
  on_mount {NewspaperWeb.UserAuth, :mount_current_user}

  @impl true
  def mount(_params, _session, socket) do
    current_user = socket.assigns.current_user
    data = Accounts.get_user_data(current_user)

    {:ok, assign(socket, data: data)}
  end

end
