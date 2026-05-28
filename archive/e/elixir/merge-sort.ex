defmodule MergeSort do
  @doc """
  Sorts a list of integers in ascending order using merge sort.
  """  
  @spec merge_sort(list :: list(integer)) :: list(integer)
  def merge_sort([]), do: []
  def merge_sort([x]), do: [x]
  def merge_sort(list) do
    {left, right} = Enum.split(list, div(length(list), 2))
    merge(merge_sort(left), merge_sort(right))
  end

  @spec merge(left :: list(integer()), right :: list(integer()), acc :: list(integer())) :: list(integer)
  defp merge(left, right, acc \\ [])
  defp merge([], right, acc), do: Enum.reverse(acc) ++ right
  defp merge(left, [], acc), do: Enum.reverse(acc) ++ left
  defp merge([x | left], [y | right], acc) do
    if x < y do
      merge(left, [y | right], [x | acc])
    else
      merge([x | left], right, [y | acc])
    end
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
     {:ok, [_, _ | _] = list} <- MergeSort.parse_list(arg) do
  MergeSort.merge_sort(list) |> Enum.join(", ") |> IO.puts()
else
  _ -> IO.puts("Usage: please provide a list of at least two integers to sort in the format \"1, 2, 3, 4, 5\"")
end
