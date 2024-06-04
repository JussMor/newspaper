defmodule NewspaperWeb.SpinnersComponent do


  use Phoenix.Component

  def  spinners(assigns) do
    ~H"""
    <div class="animate-spin inline-block w-6 h-6 border-[3px] border-current border-t-transparent text-gray-800 rounded-full " role="status" aria-label="loading">
        <span class="sr-only">Loading...</span>
    </div>
    <div class="animate-spin inline-block w-6 h-6 border-[3px] border-current border-t-transparent text-gray-400 rounded-full" role="status" aria-label="loading">
        <span class="sr-only">Loading...</span>
    </div>
    <div class="animate-spin inline-block w-6 h-6 border-[3px] border-current border-t-transparent text-red-600 rounded-full" role="status" aria-label="loading">
        <span class="sr-only">Loading...</span>
    </div>
    <div class="animate-spin inline-block w-6 h-6 border-[3px] border-current border-t-transparent text-yellow-600 rounded-full" role="status" aria-label="loading">
        <span class="sr-only">Loading...</span>
    </div>
    <div class="animate-spin inline-block w-6 h-6 border-[3px] border-current border-t-transparent text-green-600 rounded-full" role="status" aria-label="loading">
        <span class="sr-only">Loading...</span>
    </div>
    <div class="animate-spin inline-block w-6 h-6 border-[3px] border-current border-t-transparent text-blue-600 rounded-full " role="status" aria-label="loading">
        <span class="sr-only">Loading...</span>
    </div>
    <div class="animate-spin inline-block w-6 h-6 border-[3px] border-current border-t-transparent text-indigo-600 rounded-full" role="status" aria-label="loading">
        <span class="sr-only">Loading...</span>
    </div>
    <div class="animate-spin inline-block w-6 h-6 border-[3px] border-current border-t-transparent text-purple-600 rounded-full" role="status" aria-label="loading">
        <span class="sr-only">Loading...</span>
    </div>
    <div class="animate-spin inline-block w-6 h-6 border-[3px] border-current border-t-transparent text-pink-600 rounded-full" role="status" aria-label="loading">
        <span class="sr-only">Loading...</span>
    </div>
    <div class="animate-spin inline-block w-6 h-6 border-[3px] border-current border-t-transparent text-orange-600 rounded-full" role="status" aria-label="loading">
        <span class="sr-only">Loading...</span>
    </div>
    """
  end

end
