defmodule NewspaperWeb.AvatarComponent do

  use Phoenix.Component

  def  avatar(assigns) do
    ~H"""
    <div class="-space-x-5">
    <img class="relative inline-block object-cover w-8 h-8 rounded-full border-white border-2" src="/images/user/user-01.png" alt="Profile image" />
    <img class="relative inline-block object-cover w-8 h-8 rounded-full border-white border-2" src="/images/user/user-02.png" alt="Profile image" />
    <img class="relative inline-block object-cover w-8 h-8 border-2 rounded-full border-white" src="/images/user/user-03.png" alt="Profile image" />
    <div class="relative w-8 h-8 bg-indigo-600 rounded-full inline-flex items-center justify-center text-white text-sm border-2 border-white">2+</div>
    </div>
    """
  end

end
