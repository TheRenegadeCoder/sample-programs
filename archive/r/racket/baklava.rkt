#lang racket
(for ([i (in-range -10 11)])
    (define numSpaces (abs i))
    (define numStars (- 21 (* numSpaces 2)))
    (define s (make-string numSpaces #\ ))
    (define t (make-string numStars #\*))
    (printf "~a~a\n" s t)
)
