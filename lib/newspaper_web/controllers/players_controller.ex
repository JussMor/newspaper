defmodule NewspaperWeb.PlayersController do
    use NewspaperWeb, :controller

  def player(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
      json(conn, %{message: "hello"})
  end
end
