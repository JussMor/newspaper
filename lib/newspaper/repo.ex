defmodule Newspaper.Repo do
  use Ecto.Repo,
    otp_app: :newspaper,
    adapter: Ecto.Adapters.Postgres
  use Scrivener, page_size: 10
end
