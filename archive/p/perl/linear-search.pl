#!/usr/bin/perl
my $arguments_used = scalar @ARGV;
if($arguments_used < 2)
{
    die "Usage: please provide a list of integers (\"1, 4, 5, 11, 12\") and the integer to find (\"11\")\n";
}
my @input_array = @ARGV;
my $input_string = pop @ARGV;
my @trimmed_string = split(',', @input_array[0]);
my $found_it = 0;
if(scalar@trimmed_string < 1)
{
    die "Usage: please provide a list of integers (\"1, 4, 5, 11, 12\") and the integer to find (\"11\")\n";
}
for(my $i = 0; $i < scalar(@trimmed_string); $i++)
{
    if($trimmed_string[$i] == $input_string)
    {
        $found_it = 1;
    }
}
print $found_it ? "true" : "false";