#!/usr/bin/env perl
use strict;
use warnings;

# accept input as argument
my ($number) = @ARGV;

if (!defined $number || $number !~ /^\-?\d+$/) {
	print "Usage: please input a number\n";
	exit;
}

if ($number % 2 == 0) {
	print "Even\n";
} else {
	print "Odd\n";
}
