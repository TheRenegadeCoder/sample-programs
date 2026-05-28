defmodule Fibonacci do
  @doc """
  Returns the first `number` elements of the Fibonacci sequence as a list.
  """  
  @spec fibonacci(number :: integer()) :: list(integer())
  def fibonacci(number) do
    Stream.unfold({1, 1}, fn {m, n} -> {m, {n, m+n}} end)
    |> Enum.take(number)
  end
end

with [number] <- System.argv(),
     {number, ""} <- Integer.parse(number) do
  Fibonacci.fibonacci(number)
  |> Enum.with_index(1)
  |> Enum.each(fn {n, i} -> IO.puts("#{i}: #{n}") end)
else
  _ -> IO.puts("Usage: please input the count of fibonacci numbers to output")
end
