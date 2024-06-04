defmodule NewspaperWeb.BadgeComponent do

  use Phoenix.Component

  def  badge(assigns) do
    ~H"""
      <span class="bg-indigo-600 px-2 py-1 text-white text-sm font-medium rounded-md inline-block whitespace-nowrap text-center">Badge</span>
    <span class="bg-gray-500 px-2 py-1 text-white text-sm font-medium rounded-md inline-block whitespace-nowrap text-center">Badge</span>
    <span class="bg-teal-500 px-2 py-1 text-white text-sm font-medium rounded-md inline-block whitespace-nowrap text-center">Badge</span>
    <span class="bg-blue-500 px-2 py-1 text-white text-sm font-medium rounded-md inline-block whitespace-nowrap text-center">Badge</span>
    <span class="bg-red-500 px-2 py-1 text-white text-sm font-medium rounded-md inline-block whitespace-nowrap text-center">Badge</span>
    <span class="bg-yellow-500 px-2 py-1 text-white text-sm font-medium rounded-md inline-block whitespace-nowrap text-center">Badge</span>
    <span class="bg-gray-800 px-2 py-1 text-white text-sm font-medium rounded-md inline-block whitespace-nowrap text-center">Badge</span>
    <span class="bg-gray-300 px-2 py-1 text-white text-sm font-medium rounded-md inline-block whitespace-nowrap text-center">Badge</span>
    """
  end

end
