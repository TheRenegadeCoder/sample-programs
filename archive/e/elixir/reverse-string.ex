defmodule ReverseString do
  @doc """
  Reverses the string in the first argument of the argument list.

  Returns the resulting string, or an empty string if no arguments are provided.
  """
  @spec main(argv :: list(String.t())) :: String.t()
  def main([]), do: ""
  def main([input | _]), do: String.reverse(input)
end

ReverseString.main(System.argv()) |> IO.puts
