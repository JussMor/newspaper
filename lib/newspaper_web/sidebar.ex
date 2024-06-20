defmodule NewspaperWeb.Sidebar do
  use NewspaperWeb, :verified_routes

  import Plug.Conn

  def on_mount(:mount_sidebar, _params, session, socket) do
    {:cont, mount_sidebar(socket, session)}
  end

  defp mount_sidebar(socket, session) do
    Phoenix.Component.assign_new(socket, :sidebar, fn ->
      %{
        outsideToggle: false,
        darkMode: false
      }
    end)
  end

end
