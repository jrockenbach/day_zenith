defmodule DayZenith.Repo do
  use Ecto.Repo,
    otp_app: :day_zenith,
    adapter: Ecto.Adapters.Postgres
end
