(import :std/iter)
(import :std/misc/func)

(export main)

(def (string-repeat n str)
    (string-join (repeat str n) "")
)

(def (main . args)
  (for (i (in-range -10 11))
    (def num-spaces (abs i))
    (def num-stars (- 21 (* 2 num-spaces)))
    (displayln (string-repeat num-spaces " ") (string-repeat num-stars "*"))
  )
)
