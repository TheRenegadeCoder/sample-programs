use "collections"

actor Main
  new create(env: Env) =>
    for i in Range[I32](1, 100) do
      env.out.print(fizzbuzz(i))
    end

  fun fizzbuzz(n: I32): String =>
    if (n % 15) == 0 then
      "FizzBuzz"
    elseif (n % 5) == 0 then
      "Buzz"
    elseif (n % 3) == 0 then
      "Fizz"
    else
      n.string()
    end
