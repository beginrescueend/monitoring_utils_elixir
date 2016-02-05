defmodule MonitorTest do
  use ExUnit.Case

  test "Ping localhost" do
    assert Monitor.ping("127.0.0.1") == {:ok, "127.0.0.1"}
  end

  test "Ping Bad IP" do
    assert Monitor.ping("255.254.253.252") == {false, "255.254.253.252"}
  end

  test "Ping Bad Hostname" do
    assert Monitor.ping("bad_site.really.fake.example.com") == {false, "bad_site.really.fake.example.com"}
  end

  test "Ping Google" do
    assert Monitor.ping("www.google.com") == {:ok, "www.google.com"}
  end

  test "Parallel List" do
    ["127.0.0.1", "www.example.com", "www.google.com"] |> Monitor.ping_list
  end

  test "Parallel Range" do
    1..254 |> Enum.map(fn x -> "10.0.0.#{x}" end) |> Monitor.ping_list
  end

  test "Multiple Octets" do
    Monitor.ping_list(for octet1 <- 10..10, octet2 <- 0..0, octet3 <- 0..1, octet4 <- 1..254, do: "#{octet1}.#{octet2}.#{octet3}.#{octet4}")
  end
end
