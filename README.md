Monitor
======

** Bare-bones monitoring library for Elixir **

Currently, this library wraps around /os-path/to/ping and runs them in parallel.

In the future, it may use Erlang Procket or other library for ICMP...

Also, I would like to add parallel HTTP/HTTPS calls, etc., perhaps using Hackney or HTTPoison.

Note: This project was heavily inspired by https://github.com/seven1m/30-days-of-elixir/blob/master/09-ping.exs
