defmodule CryptoMonitor.Bank do
    
    use Agent
    
    def start_link do
        Agent.start_link(fn -> %{"eth" => 0, 
                                 "eth_qty" => 100_000,
                                 "btc" => 0,
                                 "btc_qty" => 100_000} end, name: __MODULE__)
    end
end
