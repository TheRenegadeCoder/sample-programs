defmodule Bubble do
  @doc """
  Sort the giveen input using bubble sort
  """
  def main(args) do
    cond do
      length(args) != 1 
      or List.first(args) == "" 
      or List.first(args) |> String.split(",") |> length < 2 ->
        IO.puts("Usage: please provide a list of at least two integers to sort in the format \"1, 2, 3, 4, 5\"")
      true ->
        input = List.first(args)
        |> String.split(",") 
        |> Enum.map(&String.trim/1)
        |> Enum.map(&String.to_integer/1)
        sorted_list = pass(input, [])
        IO.puts(Enum.join(sorted_list, ", "))
    end
  end

  @doc """
  Handle each pass, return the list when there are no more changes to the list
  """
  def pass(new_list, old_list) when new_list == old_list, do: new_list

  def pass(new_list, old_list) when new_list != old_list do
    passed_list = sort(new_list, [])
    pass(passed_list, new_list)
  end

  @doc """
  Add the smaller element to accumulator, recursively call sort until all elements are added to accumulator
  """
  def sort([], acc), do: acc

  def sort([head, tail], acc) do
    if head > tail, do: sort([], acc ++ [tail, head]), else: sort([], acc ++ [head, tail])
  end

  def sort([head | [head2 | tail]], acc) do
    if head > head2, do: sort([head | tail], acc ++ [head2]), else: sort([head2 | tail], acc ++ [head])
  end
end

Bubble.main(System.argv())
