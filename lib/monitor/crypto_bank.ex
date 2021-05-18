defmodule CryptoMonitor.Bank do
    
    use Agent
    
    def start_link do
        Agent.start_link(fn -> %{"eth" => 0, 
                                 "eth_qty" => 100_000,
                                 "btc" => 0,
                                 "btc_qty" => 100_000} end, name: __MODULE__)
    end

    def update(key, value) do
        Agent.update(__MODULE__, &Map.put(&1, key, value))
    end

    def get(key) do
        Agent.get(__MODULE__, &Map.get(&1, key))
    end
end
