defmodule DayZenith.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      DayZenithWeb.Telemetry,
      DayZenith.Repo,
      {DNSCluster, query: Application.get_env(:day_zenith, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: DayZenith.PubSub},
      # Start a worker by calling: DayZenith.Worker.start_link(arg)
      # {DayZenith.Worker, arg},
      # Start to serve requests, typically the last entry
      DayZenithWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: DayZenith.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    DayZenithWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
