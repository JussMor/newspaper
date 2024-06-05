defmodule NewspaperWeb.CardComponent do
  use Phoenix.Component

  def card(%{type: "simple-card"} = assigns) do
    ~H"""
    <div class="card shadow" style="width: 390px">
      <img
        class="w-full h-auto rounded-t-md"
        src="/images/cards/cards-01.png"
        alt="Image Description"
      />
      <div class="flex-1 p-4">
        <h3 class="text-lg font-bold">Card title</h3>
        <p class="mt-1">
          Some quick example text to build on the card title and make up the bulk of the card's content.
        </p>
        <a
          class="inline-block px-4 py-2 mt-2  rounded-md gap-x-2 bg-indigo-600 text-white border-indigo-600 disabled:opacity-50 disabled:pointer-events-none hover:bg-indigo-800 hover:border-indigo-800 active:bg-indigo-800 active:border-indigo-800 focus:outline-none focus:ring-4 focus:ring-indigo-300"
          href="#"
        >
          Go somewhere
        </a>
      </div>
    </div>
    """
  end

  def card(assigns) do
    ~H"""
    <div class="shadow bg-white ">
      <%= render_slot(@inner_block) %>
    </div>
    """
  end

end
