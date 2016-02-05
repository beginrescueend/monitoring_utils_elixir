 defmodule Monitor do
  def ping(ip) do
    Util.Monitor.ping(ip)
  end
  def ping_list(ip_list) do
    Util.Monitor.ping_list(ip_list)
  end
end
