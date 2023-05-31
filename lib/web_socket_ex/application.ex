defmodule WebSocketEx.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      WebSocketExWeb.Telemetry,
      # Start the Ecto repository
      WebSocketEx.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: WebSocketEx.PubSub},
      # Start Finch
      {Finch, name: WebSocketEx.Finch},
      # Start the Endpoint (http/https)
      WebSocketExWeb.Endpoint
      # Start a worker by calling: WebSocketEx.Worker.start_link(arg)
      # {WebSocketEx.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: WebSocketEx.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    WebSocketExWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
