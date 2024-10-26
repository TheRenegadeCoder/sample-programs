(define string-repeat
  N C -> (if (> N 0) (cn C (string-repeat (- N 1) C)) "")
)

(define abs
  N -> (if (< N 0) (- 0 N) N)
)

(define spaces
  N -> (string-repeat (abs N) " ")
)

(define stars
  N -> (string-repeat (- 21 (* 2 (abs N))) "*")
)

(define baklava
  N -> (if (<= N 10)
    (do
      (output "~A~A~%" (spaces N) (stars N))
      (baklava (+ 1 N))
    )
    (output "")
  )
)

(baklava -10)
