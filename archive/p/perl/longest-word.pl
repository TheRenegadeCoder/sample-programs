#!/usr/bin/env perl
use v5.42;
use List::Util qw/max/;

sub usage { say "Usage: please provide a string"; exit }

my $input = "@ARGV";
$input =~ s/^\s+|\s+$//g;

usage unless length $input;
say max map length, split /\s+/, $input;