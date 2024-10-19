for -10 .. 10 {
    my $numSpaces = $_.abs;
    say (" " x $numSpaces) ~ ("*" x (21 - 2 * $numSpaces));
}
