defmodule NewspaperWeb.TooltipComponent do
  use Phoenix.Component

  def tooltip(assigns) do
    assigns =
      assigns
      |> assign_new(:position, fn -> "top" end)
      |> assign_new(:class, fn -> "" end)

    ~H"""
    <div class="relative group inline-block">
      <%= render_slot(@inner_block) %>
      <div
        class={"absolute hidden group-hover:block bg-gray-700 text-black text-xs rounded py-1 px-2 z-10 " <>
              tooltip_position_class(@position) <> " " <> @class}>
        <%= @text %>
      </div>
    </div>
    """
  end

  defp tooltip_position_class("top"), do: "bottom-full left-1/2 transform -translate-x-1/2 mb-2"
  defp tooltip_position_class("bottom"), do: "top-full left-1/2 transform -translate-x-1/2 mt-2"
  defp tooltip_position_class("left"), do: "right-full top-1/2 transform -translate-y-1/2 mr-2"
  defp tooltip_position_class("right"), do: "left-full top-1/2 transform -translate-y-1/2 ml-2"
end
