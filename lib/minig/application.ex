defmodule Minig.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Minig.Repo,
      # Start the Telemetry supervisor
      MinigWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Minig.PubSub},
      # Start the Endpoint (http/https)
      MinigWeb.Endpoint
      # Start a worker by calling: Minig.Worker.start_link(arg)
      # {Minig.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Minig.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    MinigWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
