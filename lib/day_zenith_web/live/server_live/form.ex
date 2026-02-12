defmodule DayZenithWeb.ServerLive.Form do
  use DayZenithWeb, :live_view

  alias DayZenith.Servers
  alias DayZenith.Servers.Server

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.header>
        {@page_title}
        <:subtitle>Use this form to manage server records in your database.</:subtitle>
      </.header>

      <.form for={@form} id="server-form" phx-change="validate" phx-submit="save">
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:status]} type="text" label="Status" />
        <.input field={@form[:player_count]} type="number" label="Player count" />
        <.input field={@form[:max_players]} type="number" label="Max players" />
        <.input field={@form[:ping]} type="number" label="Ping" />
        <.input field={@form[:time_of_day]} type="text" label="Time of day" />
        <.input field={@form[:map_name]} type="text" label="Map name" />
        <.input field={@form[:last_fetched_at]} type="datetime-local" label="Last fetched at" />
        <footer>
          <.button phx-disable-with="Saving..." variant="primary">Save Server</.button>
          <.button navigate={return_path(@return_to, @server)}>Cancel</.button>
        </footer>
      </.form>
    </Layouts.app>
    """
  end

  @impl true
  def mount(params, _session, socket) do
    {:ok,
     socket
     |> assign(:return_to, return_to(params["return_to"]))
     |> apply_action(socket.assigns.live_action, params)}
  end

  defp return_to("show"), do: "show"
  defp return_to(_), do: "index"

  defp apply_action(socket, :edit, %{"id" => id}) do
    server = Servers.get_server!(id)

    socket
    |> assign(:page_title, "Edit Server")
    |> assign(:server, server)
    |> assign(:form, to_form(Servers.change_server(server)))
  end

  defp apply_action(socket, :new, _params) do
    server = %Server{}

    socket
    |> assign(:page_title, "New Server")
    |> assign(:server, server)
    |> assign(:form, to_form(Servers.change_server(server)))
  end

  @impl true
  def handle_event("validate", %{"server" => server_params}, socket) do
    changeset = Servers.change_server(socket.assigns.server, server_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"server" => server_params}, socket) do
    save_server(socket, socket.assigns.live_action, server_params)
  end

  defp save_server(socket, :edit, server_params) do
    case Servers.update_server(socket.assigns.server, server_params) do
      {:ok, server} ->
        {:noreply,
         socket
         |> put_flash(:info, "Server updated successfully")
         |> push_navigate(to: return_path(socket.assigns.return_to, server))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_server(socket, :new, server_params) do
    case Servers.create_server(server_params) do
      {:ok, server} ->
        {:noreply,
         socket
         |> put_flash(:info, "Server created successfully")
         |> push_navigate(to: return_path(socket.assigns.return_to, server))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp return_path("index", _server), do: ~p"/servers"
  defp return_path("show", server), do: ~p"/servers/#{server}"
end
