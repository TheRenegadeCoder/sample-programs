defmodule Factorial do
  def main(args) do
    args
    |> List.first
    |> as_integer
    |> get
    |> IO.puts()
  end

  def get(0, acc) do
    acc
  end

  def get(n, acc) do
    get(n - 1, acc * n)
  end

  def get(n) when not is_integer(n) or n < 0 do
    "Usage: please input a non-negative integer"
  end

  def get(n) do
    get(n, 1)
  end

  def as_integer(n) do
    try do
        String.to_integer(n)
    rescue
        ArgumentError -> -1
    end
  end
end

Factorial.main(System.argv())
