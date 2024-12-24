for (21) n:
    var num_spaces = abs(n - 10)
    var num_stars = 21 - 2 * num_spaces
    var spaces = repeat_string(" ", num_spaces)
    var stars = repeat_string("*", num_stars)
    print "{spaces}{stars}"
