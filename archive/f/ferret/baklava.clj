(defn print-repeat-string
  ([s n]
    (if (> n 0)
      (do
        (print s)
        (print-repeat-string s (dec n))
      )
    )
  )
)

(defn baklava-line
  ([n]
    (let [
      num-spaces (abs n)
      num-stars (- 21 (* 2 num-spaces))
    ]
      (print-repeat-string " " num-spaces)
      (print-repeat-string "*" num-stars)
      (println)
    )
  )
)

(defn baklava
  ([n ne]
    (if (<= n ne)
      (do
        (baklava-line n)
        (baklava (inc n) ne)
      )
    )
  )
)

(do
  (baklava -10 10)
)
