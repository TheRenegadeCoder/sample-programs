#!/usr/bin/env perl
use v5.42;

sub usage {
    say "Usage: please input the count of fibonacci numbers to output";
    exit;
}

my ($n) = @ARGV;
usage() unless defined $n && $n =~ /\A\d+\z/;

my ( $a, $b ) = ( 0, 1 );

for my $i ( 1 .. $n ) {
    ( $a, $b ) = ( $b, $a + $b );
    say "$i: $a";
}
