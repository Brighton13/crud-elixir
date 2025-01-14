defmodule Crud.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      CrudWeb.Telemetry,
      Crud.Repo,
      {Ecto.Migrator,
        repos: Application.fetch_env!(:crud, :ecto_repos),
        skip: skip_migrations?()},
      {DNSCluster, query: Application.get_env(:crud, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Crud.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Crud.Finch},
      # Start a worker by calling: Crud.Worker.start_link(arg)
      # {Crud.Worker, arg},
      # Start to serve requests, typically the last entry
      CrudWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Crud.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CrudWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  defp skip_migrations?() do
    # By default, sqlite migrations are run when using a release
    System.get_env("RELEASE_NAME") != nil
  end
end
