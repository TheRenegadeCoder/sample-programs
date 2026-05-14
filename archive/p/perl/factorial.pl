#!/usr/bin/env perl
use v5.42;

sub usage {
    say "Usage: please input a non-negative integer";
    exit;
}

my ($number) = @ARGV;
usage() unless defined $number && $number =~ /\A\d+\z/;

my $factorial = 1;
$factorial *= $_ for 2 .. $number;

say $factorial;
