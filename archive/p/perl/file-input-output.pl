#!/usr/bin/env perl

sub Main {
	Write("Some arbitrary data.");
	Read();
	exit(0);
}

sub Write {
	open(my $writing, ">output.txt") || die "File could not be written.\nError: $!";

	print $writing "@_"."\n";

	close($writing) || die "The file could not be closed on write.\nError: $!";
}

sub Read {
	open(my $reading, "<output.txt") || die "File could not be readed.\nError: $!";

	while (!eof($reading)) {
		print <$reading>;
	}

	close($reading) || die "The file could not be closed on reading.\nError: $!";
}

Main();
