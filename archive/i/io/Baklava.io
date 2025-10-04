baklavaLine := method(n,
    num_spaces := n abs
    num_stars := 21 - (2 * num_spaces)
    (" " repeated(num_spaces)) .. ("*" repeated(num_stars))
)

for(n, -10, 10, baklavaLine(n) println)
