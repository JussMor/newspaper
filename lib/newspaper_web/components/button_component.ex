defmodule NewspaperWeb.ButtonComponent do

  use Phoenix.Component

  def  buttoncustom(assigns) do
    ~H"""
    <button
        type="button"
        class="inline-block px-4 py-2 mt-2  rounded-md gap-x-2 bg-indigo-600 text-white border-indigo-600 disabled:opacity-50 disabled:pointer-events-none hover:bg-indigo-800 hover:border-indigo-800 active:bg-indigo-800 active:border-indigo-800 focus:outline-none focus:ring-4 focus:ring-indigo-300"
      >
        Button
      </button>
      <button
        type="button"
        class="inline-block px-4 py-2 mt-2  rounded-md gap-x-2 bg-gray-400 text-gray-800 border-gray-400 disabled:opacity-50 disabled:pointer-events-none hover:text-white hover:bg-gray-600 hover:border-gray-600 active:bg-gray-600 active:border-gray-600 focus:outline-none focus:ring-4 focus:ring-gray-300"
      >
        Button
      </button>
      <button
        type="button"
        class="inline-block px-4 py-2 mt-2  rounded-md gap-x-2 bg-teal-600 text-white border-teal-600 disabled:opacity-50 disabled:pointer-events-none hover:text-white hover:bg-teal-700 hover:border-teal-700 active:bg-teal-700 active:border-teal-700 focus:outline-none focus:ring-4 focus:ring-teal-300"
      >
        Button
      </button>
      <button
        type="button"
        class="inline-block px-4 py-2 mt-2  rounded-md gap-x-2 bg-blue-700 text-white border-blue-700 disabled:opacity-50 disabled:pointer-events-none hover:text-white hover:bg-blue-700 hover:border-blue-700 active:bg-blue-700 active:border-blue-700 focus:outline-none focus:ring-4 focus:ring-blue-300"
      >
        Button
      </button>
      <button
        type="button"
        class="inline-block px-4 py-2 mt-2  rounded-md gap-x-2 bg-red-600 text-white border-red-600 disabled:opacity-50 disabled:pointer-events-none hover:text-white hover:bg-red-700 hover:border-red-700 active:bg-red-700 active:border-red-700 focus:outline-none focus:ring-4 focus:ring-red-300"
      >
        Button
      </button>
      <button
        type="button"
        class="inline-block px-4 py-2 mt-2  rounded-md gap-x-2 bg-yellow-600 text-white border-yellow-600 disabled:opacity-50 disabled:pointer-events-none hover:text-white hover:bg-yellow-700 hover:border-yellow-700 active:bg-yellow-700 active:border-yellow-700 focus:outline-none focus:ring-4 focus:ring-yellow-300"
      >
        Button
      </button>
      <button
        type="button"
        class="inline-block px-4 py-2 mt-2  rounded-md gap-x-2 bg-gray-800 text-white border-gray-800 disabled:opacity-50 disabled:pointer-events-none hover:text-white hover:bg-gray-900 hover:border-gray-900 active:bg-gray-900 active:border-gray-900 focus:outline-none focus:ring-4 focus:ring-gray-300"
      >
        Button
      </button>
      <button
        type="button"
        class="inline-block px-4 py-2 mt-2  rounded-md gap-x-2 bg-gray-300 text-white border-gray-300 disabled:opacity-50 disabled:pointer-events-none hover:text-white hover:bg-gray-700 hover:border-gray-700 active:bg-gray-700 active:border-gray-700 focus:outline-none focus:ring-4 focus:ring-gray-300"
      >
        Button
      </button>
      <button
        type="button"
        class="inline-block px-4 py-2 mt-2  rounded-md gap-x-2 bg-white text-gray-800 border-white disabled:opacity-50 disabled:pointer-events-none hover:text-white hover:bg-gray-700 hover:border-gray-700 active:bg-gray-700 active:border-gray-700 focus:outline-none focus:ring-4 focus:ring-gray-300"
      >
        Button
      </button>
    """
  end

end
