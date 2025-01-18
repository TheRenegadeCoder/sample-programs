for n in -10..10 {
    var num_spaces = abs(n);
    var num_stars = 21 - 2 * num_spaces;
    writeln(" " * num_spaces + "*" * num_stars);
}
