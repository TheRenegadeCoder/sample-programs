#!/usr/bin/env perl
use v5.42;

sub usage {
    say "Usage: please input a non-negative integer";
    exit;
}

my ($n) = @ARGV;
usage() unless defined $n && $n =~ /\A\d+\z/;

$n += 0;

say "Composite" and exit if $n < 2;
say "Prime"     and exit if $n == 2;
say "Composite" and exit if $n % 2 == 0;

for ( my $i = 3 ; $i * $i <= $n ; $i += 2 ) {
    say "Composite" and exit if $n % $i == 0;
}

say "Prime";
