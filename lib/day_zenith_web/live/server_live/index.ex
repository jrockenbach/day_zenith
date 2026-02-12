defmodule DayZenithWeb.ServerLive.Index do
  use DayZenithWeb, :live_view

  alias DayZenith.Servers

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Listing Servers")
     |> stream(:servers, list_servers())}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    server = Servers.get_server!(id)
    {:ok, _} = Servers.delete_server(server)

    {:noreply, stream_delete(socket, :servers, server)}
  end

  defp list_servers() do
    Servers.list_servers()
  end
end
