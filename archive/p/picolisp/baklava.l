(de repeat_string (S N)
  (if (> N 0)
    (pack S (repeat_string S (- N 1)))
    ""
  )
)

(for X 21
  (setq N (- X 11))
  (setq NSP (abs N))
  (setq NST (- 21 (* 2 NSP)))
  (prinl (pack (repeat_string " " NSP) (repeat_string "*" NST)))
)
(bye)
