(define (string-repeat n str)
  (fold string-append "" (make-list n str))
)

(define (baklava-line i stop)
  (define numSpaces (abs i))
  (define numStars (- 21 (* 2 numSpaces)))
  (when (<= i stop)
    (display (string-repeat numSpaces " "))
    (display (string-repeat numStars "*"))
    (newline)
    (baklava-line (+ i 1) stop)
  )
)

(baklava-line -10 10)
