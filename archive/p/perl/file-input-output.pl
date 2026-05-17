#!/usr/bin/env perl
use v5.42;
use IO::File;

my $file    = "output.txt";
my $content = <<'EOF';
Perl is cool!
There's more than one way to do it.
EOF

# Write to file

my $w = IO::File->new(">$file") or die "Cannot open $file for writing: $!";
$w->print($content)             or die "Write failed: $!";
$w->close                       or die "Cannot close after write: $!";

# Read from file

my $r = IO::File->new("<$file") or die "Cannot open $file for reading: $!";
print while <$r>;
$r->close or die "Cannot close after read: $!";
