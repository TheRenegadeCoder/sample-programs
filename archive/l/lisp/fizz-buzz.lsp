(defun divides-by (num divisor)
    (= (mod num divisor) 0))

(dotimes (num 100)
    (write-line
      (cond
        ((and (divides-by (+ num 1) 3) (divides-by (+ num 1) 5)) "FizzBuzz")
        ((divides-by (+ num 1) 3) "Fizz")
        ((divides-by (+ num 1) 5) "Buzz")
        (t (write-to-string (+ num 1))))))