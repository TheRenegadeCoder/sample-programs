(loop [n :range [1 101]]
  (print (cond
    (zero? (% n 15)) "FizzBuzz"
    (zero? (% n 5)) "Buzz"
    (zero? (% n 3)) "Fizz"
    n)))
