#!/usr/bin/env perl
use v5.42;

my $size = 10;

for my $i ( -$size .. $size ) {
    my $spaces = abs($i);
    my $stars  = 2 * ( $size - $spaces ) + 1;

    say ' ' x $spaces, '*' x $stars;
}
