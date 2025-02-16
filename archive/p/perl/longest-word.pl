#!/usr/bin/perl
my $args = join(" ", @ARGV);
if($args eq "" || $args eq " ")
{
    die "Usage: please provide a string\n"
}

