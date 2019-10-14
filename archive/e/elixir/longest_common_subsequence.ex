# Run Command: elixir longest_common_subsequence.ex "1, 2, 3" "2, 3, 4"
# created date : 14 October, 2019

defmodule LongestCommonSubsequence do
  def main() do
    lcs = solve(System.argv())
    IO.puts("The longest common subsequence is [#{lcs}] \n")
  end

  def solve([as, bs]) when is_bitstring(as) and is_bitstring(bs) do
    lcs(parse_string_to_list_integer(as), parse_string_to_list_integer(bs)) |> Enum.join(", ")
  end

  def solve(_) do
    print_usage()
  end

  def print_usage() do
    ~s(usage: please provide two lists in the format "1, 2, 3, 4, 5")
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

LongestCommonSubsequence.main

ExUnit.start()

defmodule LongestCommonSubsequenceTests do
  use ExUnit.Case

  test "No input" do
    assert is_bitstring(LongestCommonSubsequence.solve([]))
  end

  test "Empty input" do
    assert is_bitstring(LongestCommonSubsequence.solve([""]))
  end

  test "Missing Input" do
    assert is_bitstring(LongestCommonSubsequence.solve(["25, 15, 10, 5"]))
  end

  test "Sample Input: Same Length" do
    assert LongestCommonSubsequence.solve(["1, 4, 5, 3, 15, 6", "1, 7, 4, 5, 11, 6"]) == "1, 4, 5, 6"
  end

  test "Sample Input: Different Lengths" do
    assert LongestCommonSubsequence.solve(["1, 4, 8, 6, 9, 3, 15, 11, 6", "1, 7, 4, 5, 8, 11, 6"]) ==
             "1, 4, 8, 11, 6"
  end
end


