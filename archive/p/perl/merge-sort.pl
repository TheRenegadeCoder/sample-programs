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

# Note: Perl's `sort` is implemented via merge sort as of v5.42, so one could use that instead.

sub merge_sort ($a) {
    return $a if @$a <= 1;

    my $mid = @$a >> 1;

    my $left  = [ @{$a}[ 0 .. $mid - 1 ] ];
    my $right = [ @{$a}[ $mid .. $#$a ] ];

    merge_sort($left);
    merge_sort($right);

    @$a = _merge( $left, $right );
    return $a;
}

sub _merge ( $left, $right ) {
    my @out;

    while ( @$left && @$right ) {
        push @out, $left->[0] <= $right->[0]
          ? shift @$left
          : shift @$right;
    }

    push @out, @$left, @$right;

    return @out;
}

my ($input) = @ARGV;
my $a = parse_list($input) or usage();

merge_sort($a);
say join ', ', @$a;
