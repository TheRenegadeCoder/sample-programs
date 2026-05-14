#!/usr/bin/env perl
use v5.42;

sub fizzbuzz ($n) {
    my $s = '';

    $s .= "Fizz" if $n % 3 == 0;
    $s .= "Buzz" if $n % 5 == 0;

    return $s || $n;
}

say fizzbuzz($_) for 1 .. 100;
