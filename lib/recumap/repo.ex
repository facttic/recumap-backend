defmodule Recumap.Repo do
  use Ecto.Repo,
    otp_app: :recumap,
    adapter: Ecto.Adapters.Postgres
end
