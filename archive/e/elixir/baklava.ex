defmodule Baklava do
  @doc """
  Create baklava where the top has 10 spaces and then 1 asterisk.
  """
  @spec baklava() :: String.t()
  def baklava, do: baklava_grow(10, 1)

  @doc """
  Recursively grow the baklava until spaces <= zero.
  """
  @spec baklava_grow(spaces :: integer, asterisks :: integer) :: String.t()
  def baklava_grow(spaces, asterisks) when spaces <= 0 do
    line(0, asterisks) <> "\n" <> baklava_shrink(1, asterisks - 2)
  end

  def baklava_grow(spaces, asterisks) do
    line(spaces, asterisks) <> "\n" <> baklava_grow(spaces - 1, asterisks + 2)
  end

  @doc """
  Recursively shrink the baklava until asterisks <= zero.
  """
  @spec baklava_shrink(spaces :: integer, asterisks :: integer) :: String.t()
  def baklava_shrink(spaces, asterisks) when asterisks <= 1, do: line(spaces, 1)

  def baklava_shrink(spaces, asterisks) do
    line(spaces, asterisks) <> "\n" <> baklava_shrink(spaces + 1, asterisks - 2)
  end

  @doc """
  Return a single line of the baklava.
  """
  @spec line(spaces :: integer, asterisks :: integer) :: String.t()
  def line(spaces, asterisks) do
    String.duplicate(" ", spaces) <> String.duplicate("*", asterisks)
  end
end

Baklava.baklava() |> IO.puts()
