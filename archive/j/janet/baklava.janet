(for n -10 11
    (let [num_spaces (math/abs n)
        num_stars (- 21 (* 2 num_spaces))]
        (print (string/repeat " " num_spaces) (string/repeat "*" num_stars))
    )
)
