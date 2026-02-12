defmodule DayZenith.Servers.Server do
  use Ecto.Schema
  import Ecto.Changeset

  schema "servers" do
    field :name, :string
    field :status, :string
    field :player_count, :integer
    field :max_players, :integer
    field :ping, :integer
    field :time_of_day, :string
    field :map_name, :string
    field :last_fetched_at, :utc_datetime

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(server, attrs) do
    server
    |> cast(attrs, [:name, :status, :player_count, :max_players, :ping, :time_of_day, :map_name, :last_fetched_at])
    |> validate_required([:name, :status, :player_count, :max_players, :ping, :time_of_day, :map_name, :last_fetched_at])
  end
end
