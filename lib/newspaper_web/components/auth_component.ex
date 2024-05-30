defmodule NewspaperWeb.AuthComponent do
  use Phoenix.LiveComponent


  def render(assigns) do
    assigns =
      assigns
      |> Map.put_new(:class, "")
      |> Map.put_new(:role_to_check, [])

    ~H"""
    <div class={@class}>
      <%= if user_has_role?(@data.roles, @role_to_check) and user_has_permission?(@data.permissions, @permission_to_check) do %>
        <%= render_slot(@inner_block) %>
      <% end %>
    </div>
    """
  end

  defp user_has_role?(roles, []), do: Enum.any?(roles, &(&1 in roles))
  defp user_has_role?(roles, role_to_check) do
    Enum.any?(roles, fn role -> role in role_to_check end)
  end


  defp user_has_permission?(permissions, permission_to_check) do
    Enum.any?(permissions, fn permission -> permission in permission_to_check end)
  end
end
