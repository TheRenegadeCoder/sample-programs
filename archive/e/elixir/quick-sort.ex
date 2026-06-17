defmodule QuickSort do
  @doc """
  Sorts a list of integers in ascending order using the quicksort algorithm.
  """
  @spec quick_sort(list :: list(integer())) :: list(integer())
  def quick_sort([]), do: []

  def quick_sort([x | xs]) do
    {left, right} = Enum.split_with(xs, &(&1 < x))
    quick_sort(left) ++ [x] ++ quick_sort(right)
  end

  @spec parse_list(str :: String.t()) :: {:ok, list(integer())} | :error
  def parse_list(""), do: :error

  def parse_list(str) do
    str
    |> String.split(",")
    |> Enum.map(&String.trim/1)
    |> Enum.reduce_while({:ok, []}, fn n, {:ok, acc} ->
      case Integer.parse(n) do
        {n, ""} -> {:cont, {:ok, [n | acc]}}
        _ -> {:halt, :error}
      end
    end)
  end
end

with [arg] <- System.argv(),
     {:ok, [_, _ | _] = list} <- QuickSort.parse_list(arg) do
  QuickSort.quick_sort(list) |> Enum.join(", ") |> IO.puts()
else
  _ ->
    IO.puts(
      "Usage: please provide a list of at least two integers to sort in the format \"1, 2, 3, 4, 5\""
    )
end
