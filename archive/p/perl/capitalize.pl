#!/usr/bin/env perl
use v5.42;

sub usage {
    say "Usage: please provide a string";
    exit;
}

my ($string) = @ARGV;
usage() unless defined $string && length $string;

say ucfirst $string;
