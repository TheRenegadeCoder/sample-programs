(dotimes (run 100) 
    (setq num (+ run 1))
    (write-line (cond 
        ((and (= (mod num 3) 0) (= (mod num 5) 0)) "FizzBuzz")
        ((= (mod num 3) 0) "Fizz")
        ((= (mod num 5) 0) "Buzz")
        (t (write-to-string num))
    ))
)