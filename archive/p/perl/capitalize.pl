#!/usr/bin/env perl
use strict;
use warnings;

# accept input as argument
my ($string) = @ARGV;

if (!defined $string) {
	print "Usage: please provide a string\n";
	exit;
}

print ucfirst $string, "\n";
