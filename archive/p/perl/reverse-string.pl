#!/usr/bin/env perl
use v5.42;

my ($str) = @ARGV;
say scalar reverse $str if defined $str;
