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

sub bubble_sort ($a) {
    my $n = @$a;

    for my $end ( reverse 1 .. $n - 1 ) {
        my $swapped = false;

        for my $i ( 0 .. $end - 1 ) {
            next if $a->[$i] <= $a->[ $i + 1 ];
            ( $a->[$i], $a->[ $i + 1 ] ) = ( $a->[ $i + 1 ], $a->[$i] );
            $swapped = true;
        }

        last unless $swapped;
    }

    return $a;
}

my ($input) = @ARGV;
my $a = parse_list($input) or usage();

bubble_sort($a);
say join ', ', @$a;
