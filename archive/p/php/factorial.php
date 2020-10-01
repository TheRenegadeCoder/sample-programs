<?php
/**
 * by: Italo Sousa
 * its assumed that the file is running through command line
 * inputs are read from the same.
 * 
 * Max factorial supported is 170
 * 
 */

// Validation
$input = NULL;
if (
    sizeof($argv) < 2 ||
    !is_numeric($argv[1]) ||
    intval($argv[1]) < 0
) {
    echo("Usage: please input a non-negative integer\n");
    exit(0);
}

$factorial = 1;
$input = intval($argv[1]);

for ($x = $input; $x >= 1; $x--) {
    $factorial = $factorial * $x;
}

echo("$factorial\n");
