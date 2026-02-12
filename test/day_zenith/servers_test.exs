defmodule DayZenith.ServersTest do
  use DayZenith.DataCase

  alias DayZenith.Servers

  describe "servers" do
    alias DayZenith.Servers.Server

    import DayZenith.ServersFixtures

    @invalid_attrs %{name: nil, status: nil, ping: nil, player_count: nil, max_players: nil, time_of_day: nil, map_name: nil, last_fetched_at: nil}

    test "list_servers/0 returns all servers" do
      server = server_fixture()
      assert Servers.list_servers() == [server]
    end

    test "get_server!/1 returns the server with given id" do
      server = server_fixture()
      assert Servers.get_server!(server.id) == server
    end

    test "create_server/1 with valid data creates a server" do
      valid_attrs = %{name: "some name", status: "some status", ping: 42, player_count: 42, max_players: 42, time_of_day: "some time_of_day", map_name: "some map_name", last_fetched_at: ~U[2026-02-11 17:46:00Z]}

      assert {:ok, %Server{} = server} = Servers.create_server(valid_attrs)
      assert server.name == "some name"
      assert server.status == "some status"
      assert server.ping == 42
      assert server.player_count == 42
      assert server.max_players == 42
      assert server.time_of_day == "some time_of_day"
      assert server.map_name == "some map_name"
      assert server.last_fetched_at == ~U[2026-02-11 17:46:00Z]
    end

    test "create_server/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Servers.create_server(@invalid_attrs)
    end

    test "update_server/2 with valid data updates the server" do
      server = server_fixture()
      update_attrs = %{name: "some updated name", status: "some updated status", ping: 43, player_count: 43, max_players: 43, time_of_day: "some updated time_of_day", map_name: "some updated map_name", last_fetched_at: ~U[2026-02-12 17:46:00Z]}

      assert {:ok, %Server{} = server} = Servers.update_server(server, update_attrs)
      assert server.name == "some updated name"
      assert server.status == "some updated status"
      assert server.ping == 43
      assert server.player_count == 43
      assert server.max_players == 43
      assert server.time_of_day == "some updated time_of_day"
      assert server.map_name == "some updated map_name"
      assert server.last_fetched_at == ~U[2026-02-12 17:46:00Z]
    end

    test "update_server/2 with invalid data returns error changeset" do
      server = server_fixture()
      assert {:error, %Ecto.Changeset{}} = Servers.update_server(server, @invalid_attrs)
      assert server == Servers.get_server!(server.id)
    end

    test "delete_server/1 deletes the server" do
      server = server_fixture()
      assert {:ok, %Server{}} = Servers.delete_server(server)
      assert_raise Ecto.NoResultsError, fn -> Servers.get_server!(server.id) end
    end

    test "change_server/1 returns a server changeset" do
      server = server_fixture()
      assert %Ecto.Changeset{} = Servers.change_server(server)
    end
  end
end
