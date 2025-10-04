#!/usr/bin/perl
my $args = join(" ", @ARGV);
if($args eq "" || $args eq " ")
{
    die "Usage: please provide a string\n"
}
my $total = 0;
my @storage = split(" ", $args);
foreach my $loop (@storage)
{
    if(length($loop) >= $total)
    {
        $total = length($loop);
    }
}
print $total;
