defmodule Greenup.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      TwMerge.Cache,
      GreenupWeb.Telemetry,
      Greenup.Repo,
      {DNSCluster, query: Application.get_env(:greenup, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Greenup.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Greenup.Finch},
      # Start a worker by calling: Greenup.Worker.start_link(arg)
      # {Greenup.Worker, arg},
      # Start to serve requests, typically the last entry
      GreenupWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Greenup.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    GreenupWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
