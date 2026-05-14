#!/usr/bin/env perl
use v5.42;

sub usage {
    say "Usage: please input a number";
    exit;
}

my ($number) = @ARGV;

usage() unless defined $number && $number =~ /\A-?\d+\z/;

say $number % 2 == 0 ? "Even" : "Odd";
