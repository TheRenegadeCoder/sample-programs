defmodule Josephus do
  @spec josephus(n :: integer(), k :: integer()) :: integer()
  def josephus(1, _), do: 1
  def josephus(n, k), do: Integer.mod(josephus(n - 1, k) + k - 1, n) + 1
end

with [n, k] <- System.argv(),
     {n, ""} <- Integer.parse(n),
     {k, ""} <- Integer.parse(k) do
  Josephus.josephus(n, k) |> IO.puts()
else
  _ -> IO.puts("Usage: please input the total number of people and number of people to skip.")
end
