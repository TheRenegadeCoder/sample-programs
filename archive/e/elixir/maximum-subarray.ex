defmodule MaximumSubarray do

  @doc """
  Returns the maximum subarray sum of the given list using Kadane's algorithm.  
  """
  @spec maximum_subarray(argv :: list(integer())) :: integer()
  def maximum_subarray([]), do: 0
  def maximum_subarray([first | rest]) do
    {_, max_so_far} = Enum.reduce(rest, {first, first}, fn el, {max_ending_here, max_so_far} ->
      max_ending_here = max(el, el+max_ending_here) 
      {max_ending_here, max(max_so_far, max_ending_here)}
    end)
    max_so_far
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
     {:ok, [_|_] = list} <- MaximumSubarray.parse_list(arg) do
  MaximumSubarray.maximum_subarray(list) |> IO.puts()
else
  _ -> IO.puts("Usage: Please provide a list of integers in the format: \"1, 2, 3, 4, 5\"")
end

