#!/usr/bin/perl
#
# FizzBuzz in Perl

use strict;
use warnings;
use diagnostics;
use 5.10.0;

for my $n (1..100) {
    !($n % 15) ?    say "FizzBuzz"    :
    !($n % 3)  ?    say "Fizz"        :
    !($n % 5)  ?    say "Buzz"        :
                    say "$n";
}
