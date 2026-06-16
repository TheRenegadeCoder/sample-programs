defmodule MaximumArrayRotation do
  @doc """
  Returns the maximum weighted sum across all rotations of a list, where weighted sum
  is the sum of all the elements multiplied by their indices 
  """
  @spec maximum_array_rotation(arr :: list(integer())) :: integer()
  def maximum_array_rotation(arr) do
    sum = Enum.sum(arr)
    len = length(arr)

    initial =
      Enum.with_index(arr)
      |> Enum.map(fn {n, i} -> n * i end)
      |> Enum.sum()

    Enum.scan(arr, initial, &(&2 + &1 * len - sum)) |> Enum.max()
  end

  @spec parse_list(str :: String.t()) :: list(integer())
  def parse_list(""), do: []
  def parse_list(str), do: String.split(str, ", ") |> Enum.map(&String.to_integer/1)
end

with [arg] <- System.argv(),
     [_ | _] = arr <- MaximumArrayRotation.parse_list(arg) do
  MaximumArrayRotation.maximum_array_rotation(arr) |> IO.puts()
else
  _ -> IO.puts("Usage: please provide a list of integers (e.g. \"8, 3, 1, 2\")")
end
