 defmodule Monitor do
  def ping(ip) do
    Util.Monitor.ping(ip)
  end
  def ping_list(ip_list) do
    Util.Monitor.ping_list(ip_list)
  end
end

Monitor.ping_list(for outer <- 0..1, inner <- 1..254, do: "10.80.#{outer}.#{inner}")
