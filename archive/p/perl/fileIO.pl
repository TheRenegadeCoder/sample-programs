#!/usr/bin/env perl

open(my $writing, ">output.txt") || die "File could not be written.\nError: $!";

print $writing "Some arbitrary data.\n";

close($writing) || die "The file could not be closed on write.\nError: $!";

open(my $reading, "<output.txt") || die "File could not be readed.\nError: $!";

while (!eof($reading)) {
	print <$reading>;
}

close($reading) || die "The file could not be closed on reading.\nError: $!";

exit(0);
