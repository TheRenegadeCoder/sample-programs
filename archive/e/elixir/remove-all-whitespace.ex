defmodule RemoveAllWhitespace do
    @doc """
    Removes all whitespace from the first argument in the argument list.

    Returns `{:ok, result}` or `:error` if arguments are invalid.
    """
    @spec main(argv :: list(String.t())) :: {:ok, String.t()} | :error
    def main([""]), do: :error
    def main([input]), do: {:ok, String.replace(input, ~r/\s+/, "")}
    def main(_), do: :error
end

case RemoveAllWhitespace.main(System.argv()) do
  {:ok, res} -> IO.puts(res)
  :error     -> IO.puts("Usage: please provide a string")
end 
