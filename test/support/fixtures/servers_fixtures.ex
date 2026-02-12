defmodule DayZenith.ServersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `DayZenith.Servers` context.
  """

  @doc """
  Generate a server.
  """
  def server_fixture(attrs \\ %{}) do
    {:ok, server} =
      attrs
      |> Enum.into(%{
        last_fetched_at: ~U[2026-02-11 17:46:00Z],
        map_name: "some map_name",
        max_players: 42,
        name: "some name",
        ping: 42,
        player_count: 42,
        status: "some status",
        time_of_day: "some time_of_day"
      })
      |> DayZenith.Servers.create_server()

    server
  end
end
