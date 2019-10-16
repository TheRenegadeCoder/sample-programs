defmodule Factorial do
  def main(args) when length(args) == 0 do
    get(-1)
    |> IO.puts()
  end

  def main(args) do
    cond do
      length(args) == 0 ->
        get(-1)
        |> IO.puts()
      List.first(args) == "" ->
        get(-1)
        |> IO.puts()
      not is_integer(List.first(args)) ->
        get(-1)
        |> IO.puts()
      true ->
        args
        |> List.first
        |> String.to_integer
        |> get
        |> IO.puts()
    end
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
end

Factorial.main(System.argv())
