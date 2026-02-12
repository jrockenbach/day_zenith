defmodule DayZenithWeb.ServerLive.Show do
  use DayZenithWeb, :live_view

  alias DayZenith.Servers

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.header>
        Server {@server.id}
        <:subtitle>This is a server record from your database.</:subtitle>
        <:actions>
          <.button navigate={~p"/servers"}>
            <.icon name="hero-arrow-left" />
          </.button>
          <.button variant="primary" navigate={~p"/servers/#{@server}/edit?return_to=show"}>
            <.icon name="hero-pencil-square" /> Edit server
          </.button>
        </:actions>
      </.header>

      <.list>
        <:item title="Name">{@server.name}</:item>
        <:item title="Status">{@server.status}</:item>
        <:item title="Player count">{@server.player_count}</:item>
        <:item title="Max players">{@server.max_players}</:item>
        <:item title="Ping">{@server.ping}</:item>
        <:item title="Time of day">{@server.time_of_day}</:item>
        <:item title="Map name">{@server.map_name}</:item>
        <:item title="Last fetched at">{@server.last_fetched_at}</:item>
      </.list>
    </Layouts.app>
    """
  end

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Show Server")
     |> assign(:server, Servers.get_server!(id))}
  end
end
