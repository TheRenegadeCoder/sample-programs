#!/usr/bin/env perl
use v5.42;

use feature qw/keyword_any/;
no warnings 'experimental::keyword_any';

sub usage {
    say 'Usage: please provide a list of integers ("1, 4, 5, 11, 12") and the integer to find ("11")';
    exit;
}

sub parse_list ($s) {
    return undef unless defined $s;

    my @vals = split /\s*,\s*/, $s;

    return undef unless @vals;
    return undef if any { $_ !~ /\A\d+\z/ } @vals;

    @vals = map 0 + $_, @vals;

    return \@vals;
}

my ( $list_s, $num_s ) = @ARGV;

defined $num_s or usage();

my $list = parse_list($list_s) or usage();

usage() unless $num_s =~ /\A\d+\z/;
my $num = 0 + $num_s;

my $found = any { $_ == $num } @$list;
say $found ? "true" : "false";
