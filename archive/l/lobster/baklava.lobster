for (21) n:
    let num_spaces = abs(n - 10)
    let num_stars = 21 - 2 * num_spaces
    let spaces = repeat_string(" ", num_spaces)
    let stars = repeat_string("*", num_stars)
    print "{spaces}{stars}"
