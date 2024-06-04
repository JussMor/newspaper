defmodule NewspaperWeb.OffcanvasComponent do
  use Phoenix.Component

    def  offcanvas(assigns) do
    ~H"""
    <div
        class="offcanvas translate-x-full fixed top-20 right-0 border-l border-gray-300 transition-all duration-300 transform-none h-full visible bg-white z-50 max-w-xs"
        tabindex="-1"
        id="offcanvasRight"
        aria-labelledby="offcanvasRightLabel"
        >
        <div class="flex items-center p-4">
            <h5 class="text-lg" id="offcanvasRightLabel">Offcanvas</h5>
            <button type="button" class="btn-close"></button>
            <button
              type="button"
              data-bs-dismiss="offcanvas"
              aria-label="Close"
              class="text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm w-8 h-8 absolute top-2.5 end-2.5 flex items-center justify-center "
              >
              <svg class="w-3 h-3" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 14 14">
                  <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="m1 1 6 6m0 0 6 6M7 7l6-6M7 7l-6 6" />
              </svg>
              <span class="sr-only">Close menu</span>
            </button>
        </div>
        <div class="p-4">
            <div>Some text as placeholder. In real life you can have the elements you have chosen. Like, text, images, lists, etc.</div>
            <div class="dropdown mt-3">
              <button class="btn btn-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown">Dropdown button</button>
              <ul class="dropdown-menu">
                  <li><a class="dropdown-item" href="#">Action</a></li>
                  <li><a class="dropdown-item" href="#">Another action</a></li>
                  <li><a class="dropdown-item" href="#">Something else here</a></li>
              </ul>
            </div>
        </div>
      </div>
    """
  end

end
