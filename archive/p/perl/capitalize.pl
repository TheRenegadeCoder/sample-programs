#!/usr/bin/env perl
use strict;
use warnings;

# accept input as argument
my ($string) = @ARGV;

if (!defined $string || length $string == 0) {
	print "Usage: please provide a string\n";
	exit;
}

print ucfirst $string, "\n";
