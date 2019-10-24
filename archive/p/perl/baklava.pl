#!/usr/bin/env perl
use strict;
use warnings;

my $size = 10;

for my $i (1..$size){
    print " "x($size + 1 - $i), "*"x($i*2 - 1), "\n";
}

for my $j (0..$size){
    print " "x($j), "*"x($size*2 - $j*2 + 1), "\n";
}