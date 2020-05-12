defmodule Bakery.Repo do
  use Ecto.Repo,
    otp_app: :bakery,
    adapter: Ecto.Adapters.Postgres
end
