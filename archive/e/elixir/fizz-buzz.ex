1..100
|> Enum.map(fn
  n when rem(n, 3) == 0 and rem(n, 5) == 0 -> "FizzBuzz"
  n when rem(n, 3) == 0 -> "Fizz"
  n when rem(n, 5) == 0 -> "Buzz"
  n -> Integer.to_string(n)
end)
|> Enum.each(&IO.puts/1)
