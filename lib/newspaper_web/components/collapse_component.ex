defmodule NewspaperWeb.CollapseComponent do

  use Phoenix.Component

  def  collapse(assigns) do
    ~H"""
    <a
      class="inline-block px-4 py-2 mt-2  rounded-md gap-x-2 bg-indigo-600 text-white border-indigo-600 disabled:opacity-50 disabled:pointer-events-none hover:bg-indigo-800 hover:border-indigo-800 active:bg-indigo-800 active:border-indigo-800 focus:outline-none focus:ring-4 focus:ring-indigo-300 collapsed"
      href="#!"
      data-bs-toggle="collapse"
      data-bs-target="#collapseContent"
      aria-expanded="false"
      aria-controls="collapseContent"
      >
      Collapse
      </a>
      <div id="collapseContent" class="collapse">
        <div class="flex flex-1 p-4 shadow rounded-md mt-4">
            Some placeholder content for the collapse component. This panel is hidden by default but revealed when the user activates the relevant trigger.
        </div>
      </div>
    """
  end

end
