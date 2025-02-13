#!/usr/bin/perl
my $arguments_used = scalar @ARGV;

if($arguments_used < 2)
{
    die "Usage: please provide a target and a list e.g (\"1,2,3,4,5\" 5)";
}

my @input_array = @ARGV;
my $input_string = pop @ARGV;
my @trimmed_string = split(',', @input_array[0]);
my $found_it = 0;

if(scalar@trimmed_string < 2)
{
    die "Usage: please provide atleast 2 elements to the lis e.g (\"1,2\" 2)"
}

for(my $i = 0; $i < scalar(@trimmed_string); $i++)
{
    if($trimmed_string[i] == $input_string)
    {
        $found_it = 1;
    }
}

print $found_it ? "true" : "false";