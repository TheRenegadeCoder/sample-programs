defmodule PalindromicNumber do
  @doc """
  Checks whether the first argument from the args list is a palindromic number

  Returns either `{:ok, result}` or `:error` when input is empty or not a non-negative integer
  """
  @spec main(argv :: list(String.t())) :: {:ok, boolean()} | :error
  def main([number]) do
    with {number, ""} when number >= 0 <- Integer.parse(number) do
      {:ok, palindromic?(number)}
    else
      _ -> :error
    end
  end
  def main(_), do: :error

  @spec palindromic?(number :: integer()) :: boolean()
  defp palindromic?(number), do: reverse_number(number) == number

  @spec reverse_number(number :: integer(), acc :: integer()) :: integer()
  defp reverse_number(number, acc \\ 0)
  defp reverse_number(0, acc), do: acc
  defp reverse_number(number, acc), do: reverse_number(div(number, 10), acc * 10 + rem(number, 10))
end

case PalindromicNumber.main(System.argv()) do
  {:ok, res} -> IO.puts(res)
  :error     -> IO.puts("Usage: please input a non-negative integer")
end
