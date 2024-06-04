defmodule NewspaperWeb.ListComponent do

  use Phoenix.Component

  def  listcustom(assigns) do
    ~H"""
    <ul class="max-w-xs flex flex-col">
      <li
        class="inline-flex items-center gap-x-2 py-3 px-4 text-base font-medium bg-white border border-gray-300 text-gray-600 -mt-px first:rounded-t-lg first:mt-0 last:rounded-b-lg"
        >
        Profile
      </li>
      <li
        class="inline-flex items-center gap-x-2 py-3 px-4 text-base font-medium bg-white border border-gray-300 text-gray-600 -mt-px first:rounded-t-lg first:mt-0 last:rounded-b-lg"
        >
        Settings
      </li>
      <li
        class="inline-flex items-center gap-x-2 py-3 px-4 text-base font-medium bg-white border border-gray-300 text-gray-600 -mt-px first:rounded-t-lg first:mt-0 last:rounded-b-lg"
        >
        Newsletter
      </li>
	    </ul>
    """
  end

end
