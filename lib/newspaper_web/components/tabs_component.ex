defmodule NewspaperWeb.TabsComponent do

  use Phoenix.Component

  def  tabs(assigns) do
    ~H"""
    <nav class="flex border-b border-gray-300">
    <a
      class="px-4 py-3 -mb-px border-gray-300 border rounded-t-md inline-flex items-center gap-x-2 text-base font-semibold whitespace-nowrap text-indigo-600 hover:text-indigo-70 focus:outline-none focus:text-indigo-700"
      href="#"
      aria-current="page"
      >
    Active
    </a>
    <a
      class="px-4 py-3 hover:-mb-px hover:border-gray-300 hover:border hover:rounded-t-md inline-flex items-center gap-x-2 text-base whitespace-nowrap text-indigo-600 hover:text-indigo-70 focus:outline-none focus:text-indigo-700"
      href="#"
      >
    Link
    </a>
    <a
      class="px-4 py-3 hover:-mb-px hover:border-gray-300 hover:border hover:rounded-t-md inline-flex items-center gap-x-2 text-base whitespace-nowrap text-indigo-600 hover:text-indigo-70 focus:outline-none focus:text-indigo-700"
      href="#"
      >
    Link
    </a>
    <a
      class="px-4 py-3 hover:-mb-px hover:border-gray-300 hover:border hover:rounded-t-md inline-flex items-center gap-x-2 text-base whitespace-nowrap text-gray-600 hover:text-indigo-70 focus:outline-none focus:text-indigo-700 opacity-50 pointer-events-none"
      href="#"
      >
    Disabled
    </a>
    </nav>
    """
  end


end
