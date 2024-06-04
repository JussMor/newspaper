defmodule NewspaperWeb.ButtongroupComponent do

  use Phoenix.Component

  def  buttongroup(assigns) do
    ~H"""
    <div class="inline-flex ">
                          <button
                             type="button"
                             class="inline-block px-4 py-2 mt-2  rounded-md gap-x-2 -ms-px rounded-r-none focus:z-10 border border-indigo-600 bg-indigo-600 text-white shadow-sm hover:bg-indigo-800 disabled:opacity-50 disabled:pointer-events-none"
                             >
                          Left
                          </button>
                          <button
                             type="button"
                             class="inline-block px-4 py-2 mt-2  rounded-md gap-x-2 -ms-px rounded-r-none rounded-l-none focus:z-10 border border-indigo-600 bg-indigo-600 text-white shadow-sm hover:bg-indigo-800 disabled:opacity-50 disabled:pointer-events-none"
                             >
                          Middle
                          </button>
                          <button
                             type="button"
                             class="inline-block px-4 py-2 mt-2  rounded-md gap-x-2 -ms-px rounded-l-none focus:z-10 border border-indigo-600 bg-indigo-600 text-white shadow-sm hover:bg-indigo-800 disabled:opacity-50 disabled:pointer-events-none"
                             >
                          Right
                          </button>
    </div>
    """
  end

end
