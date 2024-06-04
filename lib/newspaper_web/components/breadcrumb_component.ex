defmodule NewspaperWeb.BreadcrumbComponent do

  use Phoenix.Component

  def  breadcrumb(assigns) do
    ~H"""
      <ol class="flex items-center whitespace-nowrap" aria-label="Breadcrumb">
                          <li class="inline-flex items-center">
                             <a class="flex items-center text-base text-gray-500 hover:text-indigo-600 focus:outline-none focus:text-indigo-600 " href="#">Home</a>
                             <svg class="flex-shrink-0 h-5 w-5 text-gray-400 mx-2" width="16" height="16" viewBox="0 0 16 16" fill="none" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
                                <path d="M6 13L10 3" stroke="currentColor" stroke-linecap="round" />
                             </svg>
                          </li>
                          <li class="inline-flex items-center">
                             <a class="flex items-center text-base text-gray-500 hover:text-indigo-600 focus:outline-none focus:text-indigo-600" href="#">
                                Library
                                <svg class="flex-shrink-0 h-5 w-5 text-gray-400 mx-2" width="16" height="16" viewBox="0 0 16 16" fill="none" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
                                   <path d="M6 13L10 3" stroke="currentColor" stroke-linecap="round" />
                                </svg>
                             </a>
                          </li>
                          <li class="inline-flex items-center text-base font-semibold text-gray-800 truncate" aria-current="page">Data</li>
     </ol>
    """
  end

end
