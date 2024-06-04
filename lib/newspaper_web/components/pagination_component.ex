defmodule NewspaperWeb.PaginationComponent do
    use Phoenix.Component

    def pagination(assigns) do
    ~H"""
    <nav class="flex items-center gap-x-1">
      <button
        type="button"
        class="min-h-[36px] min-w-[36px] py-2 px-2.5 inline-flex justify-center items-center gap-x-1.5 rounded-md border bg-white border-gray-300 text-gray-800 hover:bg-gray focus:outline-none focus:bg-gray-300 disabled:opacity-50 disabled:pointer-events-none"
      >
        <svg
          class="flex-shrink-0 w-3.5 h-3.5"
          xmlns="http://www.w3.org/2000/svg"
          width="24"
          height="24"
          viewBox="0 0 24 24"
          fill="none"
          stroke="currentColor"
          stroke-width="2"
          stroke-linecap="round"
          stroke-linejoin="round"
        >
          <path d="m15 18-6-6 6-6"></path>
        </svg>
        <span>Previous</span>
      </button>
      <div class="flex items-center gap-x-1">
        <button
          type="button"
          class="min-h-[36px] min-w-[36px] py-2 px-2.5 inline-flex justify-center items-center gap-x-1.5 rounded-md border bg-white border-gray-300 text-gray-800 hover:bg-gray focus:outline-none focus:bg-gray-300 disabled:opacity-50 disabled:pointer-events-none"
          aria-current="page"
        >
          1
        </button>
        <button
          type="button"
          class="min-h-[36px] min-w-[36px] py-2 px-2.5 inline-flex justify-center items-center gap-x-1.5 rounded-md border bg-white border-gray-300 text-gray-800 hover:bg-gray focus:outline-none focus:bg-gray-300 disabled:opacity-50 disabled:pointer-events-none"
        >
          2
        </button>
        <button
          type="button"
          class="min-h-[36px] min-w-[36px] py-2 px-2.5 inline-flex justify-center items-center gap-x-1.5 rounded-md border bg-white border-gray-300 text-gray-800 hover:bg-gray focus:outline-none focus:bg-gray-300 disabled:opacity-50 disabled:pointer-events-none"
        >
          3
        </button>
      </div>
      <button
        type="button"
        class="min-h-[36px] min-w-[36px] py-2 px-2.5 inline-flex justify-center items-center gap-x-1.5 rounded-md border bg-white border-gray-300 text-gray-800 hover:bg-gray focus:outline-none focus:bg-gray-300 disabled:opacity-50 disabled:pointer-events-none"
      >
        <span>Next</span>
        <svg
          class="flex-shrink-0 w-3.5 h-3.5"
          xmlns="http://www.w3.org/2000/svg"
          width="24"
          height="24"
          viewBox="0 0 24 24"
          fill="none"
          stroke="currentColor"
          stroke-width="2"
          stroke-linecap="round"
          stroke-linejoin="round"
        >
          <path d="m9 18 6-6-6-6"></path>
        </svg>
      </button>
    </nav>
    """
  end

end
