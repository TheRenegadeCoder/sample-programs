#!/usr/bin/env perl
use strict;
use warnings;

sub handle_error {
    print "Usage: please provide a list of sorted integers (\"1, 4, 5, 11, 12\") and the integer to find (\"11\")\n";
    exit(0);
}

sub check {
    my ($s) = @_;
    
    # Trim leading and trailing spaces
    $s =~ s/^\s+//;
    $s =~ s/\s+$//;
    
    # Check if there are spaces in the middle
    if ($s =~ /\s/) {
        handle_error();
    }
    
    # Check if it's a valid integer
    if ($s !~ /^-?\d+$/) {
        handle_error();
    }
    
    return int($s);
}

sub convert {
    my ($s) = @_;
    
    if (length($s) == 0) {
        handle_error();
    }
    
    my @v;
    my @parts = split(',', $s);
    
    foreach my $part (@parts) {
        push @v, check($part);
    }
    
    return @v;
}

# Main program
if (@ARGV < 2) {
    handle_error();
}

my @v = convert($ARGV[0]);
my $num = check($ARGV[1]);

# Check if array is sorted
for (my $i = 0; $i < @v - 1; $i++) {
    if ($v[$i] > $v[$i + 1]) {
        handle_error();
    }
}

# Binary search
my $start = 0;
my $end = scalar(@v);
my $ans = "false";

while ($start < $end) {
    my $mid = int(($start + $end) / 2);
    
    if ($num < $v[$mid]) {
        $end = $mid;
    }
    elsif ($v[$mid] < $num) {
        $start = $mid + 1;
    }
    elsif ($v[$mid] == $num) {
        $ans = "true";
        last;
    }
}

print "$ans\n";