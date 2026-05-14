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

sub quick_sort ($a) {
    return $a if @$a <= 1;

    my $pivot = $a->[ @$a >> 1 ];

    my @left  = grep { $_ < $pivot } @$a;
    my @mid   = grep { $_ == $pivot } @$a;
    my @right = grep { $_ > $pivot } @$a;

    return [ @{ quick_sort( \@left ) }, @mid, @{ quick_sort( \@right ) } ];
}

my ($input) = @ARGV;
my $a = parse_list($input) or usage();

$a = quick_sort($a);
say join ', ', @$a;
