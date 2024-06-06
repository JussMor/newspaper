defmodule NewspaperWeb.OffcanvasComponent do
  use Phoenix.Component

  alias Phoenix.LiveView.JS
  import NewspaperWeb.Gettext
  import NewspaperWeb.CoreComponents

  def showcanvas(js \\ %JS{}, selector) do
    JS.show(js,
      to: selector,
      transition:
        {"transition-all transform ease-out duration-300",
         "opacity-0  sm:translate-y-0 sm:scale-95",
         "opacity-100 translate-y-0 sm:scale-100"}
    )
  end

  def hidecanvas(js \\ %JS{}, selector) do
    JS.hide(js,
      to: selector,
      time: 200,
      transition:
        {"transition-all transform ease-in duration-200",
         "opacity-100 translate-y-0 sm:scale-100",
         "opacity-0 translate-y-4 sm:translate-y-0 sm:scale-95"}
    )
  end

  def show_offcanvas(js \\ %JS{}, id) when is_binary(id) do
    js
    |> JS.show(to: "##{id}")
    |> JS.show(
      to: "##{id}-bg",
      transition: {"transition-all  translate-x-full transform ease-out duration-300", "opacity-0", "opacity-100"}
    )
    |> showcanvas("##{id}-container")
    |> JS.add_class("overflow-hidden", to: "body")
    |> JS.focus_first(to: "##{id}-content")
  end

  def hide_offcanvas(js \\ %JS{}, id) do
    js
    |> JS.hide(
      to: "##{id}-bg",
      transition: {"transition-all translate-x-full transform ease-in duration-200", "opacity-100", "opacity-0"}
    )
    |> hidecanvas("##{id}-container")
    |> JS.hide(to: "##{id}", transition: {"block", "block", "hidden"})
    |> JS.remove_class("overflow-hidden", to: "body")
    |> JS.pop_focus()
  end

    def  offcanvas(assigns) do
    ~H"""
    <div
        class=" fixed top-0 right-0  h-full visible   z-[999] "
        id={@id}
        phx-mounted={@show && show_offcanvas(@id)}
        phx-remove={hide_offcanvas(@id)}
        data-cancel={JS.exec(@on_cancel, "phx-remove")}
        aria-labelledby="offcanvasRightLabel"
        >
         <div id={"#{@id}-bg"} class="bg-slate-950/30 fixed inset-0 transition-opacity" aria-hidden="true" />
        <div >
              <.focus_wrap
              id={"#{@id}-container"}
              phx-window-keydown={JS.exec("data-cancel", to: "##{@id}")}
              phx-key="escape"
              phx-click-away={JS.exec("data-cancel", to: "##{@id}")}
              class="shadow-zinc-700/10 ring-zinc-700/10 relative hidden min-h-svh  bg-white p-14 shadow-lg ring-1 transition"
            >
              <div class="absolute top-6 right-5">
                <button
                  phx-click={JS.exec("data-cancel", to: "##{@id}")}
                  type="button"
                  class="-m-3 flex-none p-3 opacity-20 hover:opacity-40"
                  aria-label={gettext("close")}
                >
                  <.icon name="hero-x-mark-solid" class="h-5 w-5" />
                </button>
              </div>
              <div id={"#{@id}-content"}>
                <%= render_slot(@inner_block) %>
              </div>
            </.focus_wrap>
        </div>
      </div>
    """
  end

end
