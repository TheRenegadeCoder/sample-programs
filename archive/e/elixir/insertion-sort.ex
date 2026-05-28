defmodule InsertionSort do

  @doc """
  Sorts a list of integers in ascending order using insertion sort.
  """  
  @spec insertion_sort(list :: list(integer()), acc :: list(integer())) :: list(integer())
  def insertion_sort(list, acc \\ [])
  def insertion_sort([], acc), do: acc
  def insertion_sort([first | rest], acc), do: insertion_sort(rest, insert_sorted(acc, first))

  @spec insert_sorted(list :: list(integer()), element :: integer()) :: list(integer())
  defp insert_sorted(list, element) do
    {left, right} = Enum.split_while(list, &(&1 < element))
    left ++ [element | right]
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
        _       -> {:halt, :error}
      end
    end)
  end
end

with [arg] <- System.argv(),
     {:ok, [_, _ | _] = list} <- InsertionSort.parse_list(arg) do
  InsertionSort.insertion_sort(list) |> Enum.join(", ") |> IO.puts()
else
  _ -> IO.puts("Usage: please provide a list of at least two integers to sort in the format \"1, 2, 3, 4, 5\"")
end
  

