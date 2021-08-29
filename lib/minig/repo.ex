defmodule Minig.Repo do
  use Ecto.Repo,
    otp_app: :minig,
    adapter: Ecto.Adapters.Postgres
end
