defmodule Monitor.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      %{
        id: CryptoMonitor.BTC,
        start: {CryptoMonitor.BTC,:start_link, [10]},
        type: :worker
      },
      %{
        id: CryptoMonitor.ETH,
        start: {CryptoMonitor.ETH,:start_link, [10]},
        type: :worker
      },
      %{
        id: CryptoMonitor.Bank,
        start: {CryptoMonitor.Bank, :start_link, []},
        type: :worker
      }
    ]
    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Monitor.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
