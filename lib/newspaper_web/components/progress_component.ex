defmodule NewspaperWeb.ProgressComponent do

  use Phoenix.Component

  def  progress(assigns) do
    ~H"""
    <div class="flex flex-col gap-4 ">
      <div class="w-full bg-gray rounded-full h-1.5">
         <div class="bg-indigo-600 h-1.5 rounded-full" style="width: 15%"></div>
      </div>
      <div class="w-full bg-gray rounded-full h-1.5">
         <div class="bg-gray-300 h-1.5 rounded-full" style="width: 15%"></div>
      </div>
      <div class="w-full bg-gray rounded-full h-1.5">
         <div class="bg-teal-500 h-1.5 rounded-full" style="width: 15%"></div>
      </div>
      <div class="w-full bg-gray rounded-full h-1.5">
         <div class="bg-blue-500 h-1.5 rounded-full" style="width: 15%"></div>
      </div>
      <div class="w-full bg-gray rounded-full h-1.5">
         <div class="bg-red-500 h-1.5 rounded-full" style="width: 15%"></div>
      </div>
      <div class="w-full bg-gray rounded-full h-1.5">
         <div class="bg-yellow-500 h-1.5 rounded-full" style="width: 15%"></div>
      </div>
      <div class="w-full bg-gray rounded-full h-1.5">
         <div class="bg-gray-800 h-1.5 rounded-full" style="width: 15%"></div>
      </div>
    </div>
    """
  end

end
