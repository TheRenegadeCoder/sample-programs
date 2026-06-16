defmodule Rot13 do
  @doc """
  Returns a string after applying the Rot-13 cypher
  """
  @spec rot13(str :: String.t()) :: String.t()
  def rot13(str), do: to_charlist(str) |> Enum.map(&rot/1) |> to_string()

  defp rot(char) when char in ?a..?z, do: rem(char - ?a + 13, 26) + ?a
  defp rot(char) when char in ?A..?Z, do: rem(char - ?A + 13, 26) + ?A
  defp rot(char), do: char
end

case System.argv() do
  [str] when byte_size(str) > 0 -> Rot13.rot13(str) |> IO.puts()
  _ -> IO.puts("Usage: please provide a string to encrypt")
end
