defmodule NewspaperWeb.AuthComponent do
  use Phoenix.LiveComponent


  def render(assigns) do
    assigns =
      assigns
      |> Map.put_new(:class, "")
      |> Map.put_new(:role_to_check, [])

    ~H"""
    <div class={@class}>
      <%= if user_has_role?(@data.roles, @role_to_check) and user_has_permission?(@data.roles, @permission_to_check) do %>
        <%= render_slot(@inner_block) %>
      <% end %>
    </div>
    """
  end

  defp user_has_role?(roles, []), do: Enum.any?(roles, &(&1 in roles))
  defp user_has_role?(roles, role_to_check) do
    role_names = Enum.map(roles, & &1.name)
    Enum.any?(role_names, fn role -> role in role_to_check end)
  end

  defp user_has_permission?(roles, permission_to_check) do
    permissions = Enum.flat_map(roles, fn role -> Enum.map(role.permissions, & &1.name) end)
    Enum.any?(permissions, fn permission -> permission in permission_to_check end)
  end
end
