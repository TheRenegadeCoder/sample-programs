defmodule PrimeNumber do
  @doc """
  Determines whether `n` is a prime number.
  """
  @spec prime?(n :: integer()) :: bool()
  def prime?(0), do: false
  def prime?(1), do: false

  def prime?(n) do
    high = trunc(:math.sqrt(n))

    if high < 2 do
      true
    else
      Enum.all?(2..high, &(rem(n, &1) != 0))
    end
  end
end

with [arg] <- System.argv(),
     {n, ""} when n >= 0 <- Integer.parse(arg) do
  IO.puts(if PrimeNumber.prime?(n), do: "prime", else: "composite")
else
  _ -> IO.puts("Usage: please input a non-negative integer")
end
