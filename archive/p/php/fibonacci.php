<?php

if ($argc < 2 || !is_numeric($argv[1]) || intval($argv[1]) < 1) {
    die("Please, provide a positive integer as argument.");
}

$input = intval($argv[1]);

$a = 0;
$b = 1;
$fibonacci = 0;

for ($index = 1; $index <= $input; $index++) {
    $fibonacci = $a + $b;
    $a = $b;
    $b = $fibonacci;
    echo "$index: $a\n";
}