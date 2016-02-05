defmodule Util.Monitor do
  require Logger

  @moduledoc """
  Util.Monitor - functions to ping a single address or to ping a list, in parallel

  This was heavily inspired by https://github.com/seven1m/30-days-of-elixir/blob/master/09-ping.exs
  """

  @doc """
  Ping a single IP address or host and return true if there is a response.
  """
  def ping(ip) do
    try do
      result = ping_cmd(ip)
      output = inspect elem(result, 0)
      ret_val = elem(result, 1)

      case ((ret_val == 0) and Regex.match?(~r/ packet loss/, output) and (not Regex.match?(~r/100(\.0)?% packet loss/, output))) do
        true -> Logger.info("Ping of #{ip} sucessful - return value: #{ret_val}.")
          {:ok, ip}
        _ -> Logger.info("Ping of #{ip} failed - return value: #{ret_val}.")
          {:false, ip}
      end
    catch
      _error, reason -> Logger.warn("Error:  #{inspect reason}")
        {:error, reason, ip}
    end
  end

  @doc """
  Ping a list of IP addresses/hostnames in parallel and return a list of responses
  """
  def ping_list(ip_list) do
    pmap(ip_list, &(ping("#{&1}")))
  end

  defp pmap(collection, func) do
    collection
    |> Enum.map(&(Task.async(fn -> func.(&1) end)))
    |> Enum.map(&Task.await/1)
  end

  # Ping arguments
  defp ping_cmd(ip) do
    System.cmd("ping", ["-c", "1", "-W", "1", ip])
  end
end

