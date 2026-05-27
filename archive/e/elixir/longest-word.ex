defmodule LongestWord do
  @doc """
  Returns the length of the longest word in the first argument of the argument list.

  Returns a usage message if no argument or an empty string is provided.  
  """
  @spec main(argv :: list(String.t())) :: {:ok, integer()} | :error
  def main(["" | _]), do: :error
  def main([str]) do
    res = str
      |> String.split()
      |> Enum.max_by(&String.length/1)
      |> String.length()
    {:ok, res}
  end
  def main(_), do: :error
end

case LongestWord.main(System.argv()) do
  {:ok, res} -> IO.puts(res)
  :error -> IO.puts("Usage: please provide a string")
end
