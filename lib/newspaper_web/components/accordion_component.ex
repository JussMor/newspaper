defmodule NewspaperWeb.AccordionComponent do
  use Phoenix.Component

  def accordion(assigns) do
    ~H"""
      <div id="accordionExample" class="space-y-3">
        <%= for {title, body, id} <- [
          {"Accordion Item #1", "This is the first item's accordion body.", "collapseOne"},
          {"Accordion Item #2", "This is the second item's accordion body.", "collapseTwo"},
          {"Accordion Item #3", "This is the third item's accordion body.", "collapseThree"}
        ] do %>
          <div class="border border-gray-400 rounded-md">
            <h2 class="accordion-header px-4 py-3">
              <button
                phx-click={Phoenix.LiveView.JS.toggle(to: "#" <> id, in: "block", out: "hidden")}
                class="text-lg font-semibold flex items-center justify-between w-full"
                type="button"
                aria-expanded="false"
                aria-controls={id}
              >
                <span><%= title %></span>
                <span>
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    width="24"
                    height="24"
                    viewBox="0 0 24 24"
                    fill="none"
                    stroke="currentColor"
                    stroke-width="2"
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    class="feather feather-chevron-down collapse-icon"
                  >
                    <polyline points="6 9 12 15 18 9"></polyline>
                  </svg>
                </span>
              </button>
            </h2>
            <div id={id} class="hidden">
              <div class="accordion-body px-4 py-3 border-t border-gray-400">
                <strong><%= body %></strong>
                It is hidden by default, until the collapse plugin adds the appropriate classes that we use to style each element. These classes control the overall appearance, as well as the showing and hiding via CSS transitions. You can modify any of this with custom CSS or overriding our default variables. It's also worth noting that just about any HTML can go within the
                <code>.accordion-body</code>, though the transition does limit overflow.
              </div>
            </div>
          </div>
        <% end %>
      </div>
    """
  end
end
