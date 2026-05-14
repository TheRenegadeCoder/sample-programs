#!/usr/bin/env perl
use v5.42;

use feature qw/keyword_any/;
no warnings 'experimental::keyword_any';

sub usage {
    say 'Usage: please provide a list of at least two integers to sort in the format "1, 2, 3, 4, 5"';
    exit;
}

sub parse_list ($s) {
    return undef unless defined $s;

    my @vals = split /\s*,\s*/, $s;

    return undef if @vals < 2;
    return undef if any { $_ !~ /\A-?\d+\z/ } @vals;

    return [ map 0 + $_, @vals ];
}

sub insertion_sort ($a) {
    for my $i ( 1 .. $#$a ) {
        my $key = $a->[$i];
        my $j   = $i - 1;

        $a->[ $j + 1 ] = $a->[$j], $j-- while $j >= 0 && $a->[$j] > $key;
        $a->[ $j + 1 ] = $key;
    }

    return $a;
}

my ($input) = @ARGV;
my $a = parse_list($input) or usage();

insertion_sort($a);
say join ', ', @$a;
