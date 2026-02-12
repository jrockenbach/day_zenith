defmodule DayZenith.Repo.Migrations.CreateServers do
  use Ecto.Migration

  def change do
    create table(:servers) do
      add :name, :string
      add :status, :string
      add :player_count, :integer
      add :max_players, :integer
      add :ping, :integer
      add :time_of_day, :string
      add :map_name, :string
      add :last_fetched_at, :utc_datetime

      timestamps(type: :utc_datetime)
    end
  end
end
