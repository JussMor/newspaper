defmodule NewspaperWeb.DropdownComponent do

  use Phoenix.Component

  def  dropdowncustom(assigns) do
    ~H"""
    <div class="dropdown">
    <button
      class="inline-block px-4 py-2 rounded-md dropdown-toggle gap-x-2 bg-indigo-600 text-white border-indigo-600 disabled:opacity-50 disabled:pointer-events-none hover:bg-indigo-800 hover:border-indigo-800 active:bg-indigo-800 active:border-indigo-800 focus:outline-none focus:ring-4 focus:ring-indigo-300 dropdown-toggle"
      type="button"
      data-bs-toggle="dropdown"
      aria-expanded="false"
      >
    Dropdown button
    </button>
    <ul class="p-2 shadow bg-white rounded-md w-[160px] ">
      <li class="hover:bg-gray w-full rounded-sm"><a class="p-2  " href="#">Action</a></li>
      <li class="hover:bg-gray w-full rounded-sm"><a class="p-2  " href="#">Another action</a></li>
      <li class="hover:bg-gray w-full rounded-sm"><a class="p-2  " href="#">Something else here</a></li>
    </ul>
    </div>
    """
  end

end
