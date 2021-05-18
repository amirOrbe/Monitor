defmodule CryptoMonitor.BTC do
    use GenServer

    def start_link(time) do
        GenServer.start_link(__MODULE__,time)
    end

    def init(time) do
        refresh(time)
        {:ok, %{time: time, value: 0}}
    end

    def handle_info(:refresh, state) do
        %{time: time, value: value} = state
        new_val = update_data(value)
        refresh(time)
        {:noreply, %{time: time, value: new_val}}
    end

    def refresh(time_in_seconds) do
        Process.send_after(self(), :refresh, (time_in_seconds * 1000))
    end

    def update_data(current_value) do
        response = HTTPotion.get "https://min-api.cryptocompare.com/data/price?fsym=BTC&tsyms=USD,MXN"
        if response.status_code == 200 do
            %{"MXN" => _mxn, "USD" => usd} = Poison.decode!(response.body)
            CryptoMonitor.Bank.update("btc", usd)
            usd
        else 
             current_value
        end
    end
end