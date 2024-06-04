defmodule NewspaperWeb.AlertComponent do

  use Phoenix.Component

  def  alert(assigns) do
    ~H"""
    <div class="bg-indigo-600 mb-3 text-white rounded-lg p-4" role="alert">
                            <span class="font-bold">Info</span>
                            alert! You should check in on some of those fields below.
                         </div>
                         <div class="bg-gray-500 mb-3 text-white rounded-lg p-4" role="alert">
                            <span class="font-bold">Secondary</span>
                            alert! You should check in on some of those fields below.
                         </div>
                         <div class="bg-teal-500 mb-3 text-white rounded-lg p-4" role="alert">
                            <span class="font-bold">Success</span>
                            alert! You should check in on some of those fields below.
                         </div>
                         <div class="bg-blue-600 mb-3 text-white rounded-lg p-4" role="alert">
                            <span class="font-bold">Info</span>
                            alert! You should check in on some of those fields below.
                         </div>
                         <div class="bg-red-500 mb-3 text-white rounded-lg p-4" role="alert">
                            <span class="font-bold">Danger</span>
                            alert! You should check in on some of those fields below.
                         </div>
                         <div class="bg-yellow-500 mb-3 text-white rounded-lg p-4" role="alert">
                            <span class="font-bold">Warning</span>
                            alert! You should check in on some of those fields below.
                         </div>
                         <div class="bg-gray-800 mb-3 text-white rounded-lg p-4" role="alert">
                            <span class="font-bold">Dark</span>
                            alert! You should check in on some of those fields below.
                         </div>
                         <div class="bg-gray-300 mb-3 text-gray-600 rounded-lg p-4" role="alert">
                            <span class="font-bold">Light</span>
                            alert! You should check in on some of those fields below.
                         </div>
    """
  end

end
