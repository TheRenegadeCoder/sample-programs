# Factorial Implentation (Recursion)
# Author : pearl2201
# Connect at : https://www.facebook.com/pearl.2201
# created date : 12 October, 2019

defmodule Factorial do
  def get(0, acc) do
    acc
  end

  def get(n, acc) do
    get(n - 1, acc * n)
  end

  def get(n) when not is_integer(n) do
    {:error, :the_input_is_not_valid}
  end

  def get(n) when n < 0 do
    {:error, :the_input_is_not_valid}
  end

  def get(n) do
    get(n, 1)
  end
end

ExUnit.start()

defmodule FactorialTests do
  use ExUnit.Case

  test "Factorial" do
    assert Factorial.get("test_string") == {:error, :the_input_is_not_valid}
    assert Factorial.get(-1) == {:error, :the_input_is_not_valid}
    assert Factorial.get(0) == 1
    assert Factorial.get(10) == 3_628_800
  end
end
