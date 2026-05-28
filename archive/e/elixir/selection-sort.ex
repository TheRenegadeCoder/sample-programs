defmodule SelectionSort do
  @doc """
  Sorts a list of integers in ascending order using selection sort.
  """  
  @spec selection_sort(list :: list(integer()), acc :: list(integer())) :: list(integer())
  def selection_sort(list, acc \\ [])
  def selection_sort([], acc), do: acc
  def selection_sort(list, acc) do
    maximum = Enum.max(list)
    selection_sort(List.delete(list, maximum), [maximum | acc])
  end

  @spec parse_list(str :: String.t()) :: {:ok, list(integer())} | :error
  def parse_list(str) do
    str
    |> String.split(",")
    |> Enum.map(&String.trim/1)
    |> Enum.reduce_while({:ok, []}, fn n, {:ok, acc} ->
      case Integer.parse(n) do
        {n, ""} -> {:cont, {:ok, [n | acc]}}
        _       -> {:halt, :error}
      end
    end)
  end
end

with [arg] <- System.argv(),
     {:ok, [_, _ | _] = list} <- SelectionSort.parse_list(arg) do
  SelectionSort.selection_sort(list) |> Enum.join(", ") |> IO.puts()
else
  _ -> IO.puts("Usage: please provide a list of at least two integers to sort in the format \"1, 2, 3, 4, 5\"")
end
