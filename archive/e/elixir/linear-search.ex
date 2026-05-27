defmodule LinearSearch do
  @doc """
  Searches for an integer in a list of integers from the argument list.

  Expects two arguments: a comma-separated list of integers (e.g. `"1, 4, 5, 11"`)
  and the integer to find (e.g. `"11"`).

  Returns `{:ok, true}` if found, `{:ok, false}` if not, and `:error` if arg is invalid.
  """
  @spec main(argv :: list(String.t())) :: {:ok, boolean()} | :error
  def main([list, target]) do
    with {:ok, list}  <- parse_list(list),
         {target, ""} <- Integer.parse(target)
    do
      {:ok, Enum.member?(list, target)} 
    else
      _ -> :error
    end
  end 
  def main(_), do: :error

  @spec parse_list(str :: String.t()) :: {:ok, list(integer())} | :error
  defp parse_list(""), do: :error
  defp parse_list(str) do
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

case LinearSearch.main(System.argv()) do
  {:ok, res} -> IO.puts(res)
  _ -> IO.puts("Usage: please provide a list of integers (\"1, 4, 5, 11, 12\") and the integer to find (\"11\")")
end

