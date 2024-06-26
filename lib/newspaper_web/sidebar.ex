defmodule NewspaperWeb.Sidebar do
  use NewspaperWeb, :verified_routes

  import Plug.Conn

  def on_mount(:mount_sidebar, _params, session, socket) do
    {:cont,
     socket
     |> mount_sidebar(socket)
     |> mount_opts(socket)}
  end

  defp mount_sidebar(socket, session) do
    Phoenix.Component.assign_new(socket, :active_tab, fn ->
      "settings"
    end)
  end

  defp mount_opts(socket, session) do
    Phoenix.Component.assign_new(socket, :active_opt, fn ->
      "roles"
    end)
  end
end
