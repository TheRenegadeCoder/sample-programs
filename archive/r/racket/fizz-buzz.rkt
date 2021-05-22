;fizzbuzz in racket
;Author: Emblazion

#lang racket
(for ([i (in-range 1 101)])
  (cond
    [(and
      (equal? 0 (modulo i 3))
      (equal? 0 (modulo i 5)))
     (printf "FizzBuzz\n")]
    [(equal? 0 (modulo i 3)) (printf "Fizz\n")]
    [(equal? 0 (modulo i 5)) (printf "Buzz\n")]
    [else (printf "~a\n" i)]))
