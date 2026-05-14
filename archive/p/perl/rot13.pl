#!/usr/bin/env perl
use v5.42;

sub usage {
    say "Usage: please provide a string to encrypt";
    exit;
}

my ($str) = @ARGV;
usage() unless defined $str && length $str;

$str =~ tr/A-Za-z/N-ZA-Mn-za-m/;
say $str;
