(define (string-repeat n str)
  (fold string-append "" (make-list n str))
)

(define (baklava-line n)
  (define num-spaces (abs n))
  (define num-stars (- 21 (* 2 num-spaces)))
  (print (string-repeat num-spaces " ") (string-repeat num-stars "*"))
)

(define (baklava n ne)
  (if (<= n ne)
    (begin
      (baklava-line n)
      (baklava (+ n 1) ne)
    )
  )
)

(λ (args) (baklava -10 10))
