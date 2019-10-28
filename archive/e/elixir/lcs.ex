defmodule LongestCommonSubsequence do
  def main() do
    lcs = solve(System.argv())
    IO.puts("#{lcs}")
  end

  def solve([as, bs]) when is_bitstring(as) and is_bitstring(bs) do
    lcs(parse_string_to_list_integer(as), parse_string_to_list_integer(bs)) |> Enum.join(", ")
  end

  def solve(_) do
    print_usage()
  end

  def print_usage() do
    ~s(Usage: please provide two lists in the format "1, 2, 3, 4, 5")
  end

  def lcs([], _) do
    []
  end

  def lcs(_, []) do
    []
  end

  def lcs([a | as], [b | bs]) when a == b do
    [a] ++ lcs(as, bs)
  end

  def lcs([a | as], [b | bs]) do
    longest(lcs(as, [b | bs]), lcs([a | as], bs))
  end

  def longest(l1, l2) do
    if Enum.count(l1) > Enum.count(l2) do
      l1
    else
      l2
    end
  end

  def parse_string_to_list_integer(xs) do
    xs
    |> String.trim()
    |> String.split(",")
    |> Enum.map(&String.to_integer(String.trim(&1)))
  end
end

LongestCommonSubsequence.main()
