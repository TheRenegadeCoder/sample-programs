(for [i -10 10]
  (let [
    num-spaces (math.abs i)
    num-stars (- 21 (* 2 num-spaces))
  ]
    (print (.. (string.rep " " num-spaces) (string.rep "*" num-stars)))
  )
)
