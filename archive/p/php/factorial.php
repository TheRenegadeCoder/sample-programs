<?php

$input = null;
if (
    sizeof($argv) < 2 ||
    !is_numeric($argv[1]) ||
    intval($argv[1]) < 0
) {
    echo ("Usage: please input a non-negative integer\n");
    exit(0);
}

$factorial = 1;
$input = intval($argv[1]);

for ($x = $input; $x >= 1; $x--) {
    $factorial = $factorial * $x;
}

echo ("$factorial\n");
