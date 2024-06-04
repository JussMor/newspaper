defmodule NewspaperWeb.TablesComponent do


  use Phoenix.Component

  def  tablecustom(assigns) do
    ~H"""
    <div class="relative overflow-x-auto">
      <table class="text-left w-full whitespace-nowrap">
        <thead class="bg-gray text-gray-700 ">
            <tr class="border-gray border-b ">
              <th scope="col" class="px-6 py-3">#</th>
              <th scope="col" class="px-6 py-3">First</th>
              <th scope="col" class="px-6 py-3">Last</th>
              <th scope="col" class="px-6 py-3">Handle</th>
            </tr>
        </thead>
        <tbody class="divide-y ">
            <tr class="border-gray border-b ">
              <td class="py-3 px-6 text-left">1</td>
              <td class="py-3 px-6 text-left">Mark</td>
              <td class="py-3 px-6 text-left">Otto</td>
              <td class="py-3 px-6 text-left">@mdo</td>
            </tr>
            <tr class="border-gray border-b ">
              <td class="py-3 px-6 text-left">2</td>
              <td class="py-3 px-6 text-left">Jacob</td>
              <td class="py-3 px-6 text-left">Thornton</td>
              <td class="py-3 px-6 text-left">@fat</td>
            </tr>
            <tr class="border-gray border-b ">
              <td class="py-3 px-6 text-left">3</td>
              <td colspan="2" class="py-3 px-6 text-left">Larry the Bird</td>
              <td class="py-3 px-6 text-left">Thornton</td>
            </tr>
        </tbody>
      </table>
    </div>
    """
  end

end
