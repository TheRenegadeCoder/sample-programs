for n in [-10..10] do
    var num_spaces = n.abs
    var num_stars = 21 - 2 * num_spaces
    print " " * num_spaces + "*" * num_stars
end
