#!/usr/bin/perl
use strict;
use warnings;
use Algorithm::Loops 'NestedLoops';
use List::Util 'reduce';
use constant NODE  => 0;
use constant PATH  => 0;
use constant CNT   => 1;
use constant DEPTH => 1;
use constant LAST  => 2;

my @str = map {chomp; $_} <DATA>;
print LCS(@str), "\n";

# Longest Common Subsequence in strings
sub LCS{
    my @str = @_;

    # Map pos of chars in each str
    my @pos;
    for my $i (0 .. $#str) {
        my $line = $str[$i];
        for (0 .. length($line) - 1) {
            my $char= substr($line, $_, 1);
            push @{$pos[$i]{$char}}, $_;
        }
    }

    # Find the shortest string
    my $sh_str = reduce {length($a) < length($b) ? $a : $b} @str;

    # Coord map & lookup of char across lines
    # Create permutations if char is duplicate
    # Skip any where char isn't in every line
    my (%lookup, @order);
    CHAR:    
    for my $char (split //, $sh_str) {
        my @map;
        for (0 .. $#pos) {
            next CHAR if ! $pos[$_]{$char};
            push @map, $pos[$_]{$char};
        }
        my $next = NestedLoops([@map]);
        while (my @char_map = $next->()) {
            my $ref = [@char_map];
            $lookup{$ref} = $char;
            push @order, $ref;
        }
    }

    # Predetermine which char mappings are greater than others
    my %greater;
    for my $i (0 .. $#order - 1) {
        for my $j ($i + 1 .. $#order) {
            my $gt = is_greater(@order[$i, $j]) or next;
            my ($lg, $sm) = $gt == 1 ? ($i, $j) : ($j, $i);
            ++$greater{$order[$sm]}[CNT];
            push @{$greater{$order[$sm]}[NODE]}, "$order[$lg]";
        }
    }

    # A max depth watermark and a path representing that depth
    my ($max, $path) = (0, '');

    # Work queue
    my @work = map [$_, 1, $_], keys %greater;

    while (@work) {
        my $item = pop @work;
        my ($cur_depth, $route, $last_node) = @{$item}[DEPTH, PATH, LAST];
        ($max, $path) = ($cur_depth, $route) if $cur_depth > $max;
        my $left = $greater{$last_node}[CNT];
        next if ! $left || $cur_depth + $left <= $max;
        push @work, map ["$route:$_", $cur_depth + 1, $_], @{$greater{$last_node}[NODE]};
    }

    my $hidden_msg = join '', map $lookup{$_}, split /:/, $path;
    return $hidden_msg;
}

# All vals in 1 ref > corresponding vals in other ref
sub is_greater {
    my ($ref1, $ref2) = @_;
    my $cmp = $ref1->[0] <=> $ref2->[0] or return;
    ($ref1->[$_] <=> $ref2->[$_]) == $cmp || return for 1 .. $#$ref1; 
    return $cmp;
}
