#!/usr/bin/env perl
use v5.42;

sub usage {
    say "Usage: please input a non-negative integer";
    exit;
}

my ($n) = @ARGV;
usage() unless defined $n && $n =~ /\A\d+\z/;
say $n eq reverse($n) ? "true" : "false";
