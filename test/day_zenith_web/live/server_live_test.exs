defmodule DayZenithWeb.ServerLiveTest do
  use DayZenithWeb.ConnCase

  import Phoenix.LiveViewTest
  import DayZenith.ServersFixtures

  @create_attrs %{name: "some name", status: "some status", ping: 42, player_count: 42, max_players: 42, time_of_day: "some time_of_day", map_name: "some map_name", last_fetched_at: "2026-02-11T17:46:00Z"}
  @update_attrs %{name: "some updated name", status: "some updated status", ping: 43, player_count: 43, max_players: 43, time_of_day: "some updated time_of_day", map_name: "some updated map_name", last_fetched_at: "2026-02-12T17:46:00Z"}
  @invalid_attrs %{name: nil, status: nil, ping: nil, player_count: nil, max_players: nil, time_of_day: nil, map_name: nil, last_fetched_at: nil}
  defp create_server(_) do
    server = server_fixture()

    %{server: server}
  end

  describe "Index" do
    setup [:create_server]

    test "lists all servers", %{conn: conn, server: server} do
      {:ok, _index_live, html} = live(conn, ~p"/servers")

      assert html =~ "Listing Servers"
      assert html =~ server.name
    end

    test "saves new server", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/servers")

      assert {:ok, form_live, _} =
               index_live
               |> element("a", "New Server")
               |> render_click()
               |> follow_redirect(conn, ~p"/servers/new")

      assert render(form_live) =~ "New Server"

      assert form_live
             |> form("#server-form", server: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#server-form", server: @create_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/servers")

      html = render(index_live)
      assert html =~ "Server created successfully"
      assert html =~ "some name"
    end

    test "updates server in listing", %{conn: conn, server: server} do
      {:ok, index_live, _html} = live(conn, ~p"/servers")

      assert {:ok, form_live, _html} =
               index_live
               |> element("#servers-#{server.id} a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/servers/#{server}/edit")

      assert render(form_live) =~ "Edit Server"

      assert form_live
             |> form("#server-form", server: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#server-form", server: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/servers")

      html = render(index_live)
      assert html =~ "Server updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes server in listing", %{conn: conn, server: server} do
      {:ok, index_live, _html} = live(conn, ~p"/servers")

      assert index_live |> element("#servers-#{server.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#servers-#{server.id}")
    end
  end

  describe "Show" do
    setup [:create_server]

    test "displays server", %{conn: conn, server: server} do
      {:ok, _show_live, html} = live(conn, ~p"/servers/#{server}")

      assert html =~ "Show Server"
      assert html =~ server.name
    end

    test "updates server and returns to show", %{conn: conn, server: server} do
      {:ok, show_live, _html} = live(conn, ~p"/servers/#{server}")

      assert {:ok, form_live, _} =
               show_live
               |> element("a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/servers/#{server}/edit?return_to=show")

      assert render(form_live) =~ "Edit Server"

      assert form_live
             |> form("#server-form", server: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, show_live, _html} =
               form_live
               |> form("#server-form", server: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/servers/#{server}")

      html = render(show_live)
      assert html =~ "Server updated successfully"
      assert html =~ "some updated name"
    end
  end
end
