(for [i 1 100]
  (if (= 0 (% i 15))
    (print "FizzBuzz")
    (if (= 0 (% i 5))
      (print "Buzz")
      (if (= 0 (% i 3))
        (print "Fizz")
        (print i)))))
