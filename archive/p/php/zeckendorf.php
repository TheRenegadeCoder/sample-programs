<?php
function usage()
{
    exit("Usage: please input a non-negative integer\n");
}

function parse_int($str_value)
{
    // Remove leading and trailing spaces
    $str_value = trim($str_value);

    // Make sure all digits
    if (preg_match("/^[+-]?\d+$/", $str_value) === FALSE)
    {
        return FALSE;
    }

    // Make sure valid integer
    if (
        filter_var(
            $str_value,
            FILTER_VALIDATE_INT,
            array(
                'options' => array(
                    'decimal' => TRUE,
                    'min_range' => PHP_INT_MIN,
                    'max_range' => PHP_INT_MAX
                )
            )
        ) === FALSE
    )
    {
        return FALSE;
    }

    return intval($str_value);
}

function get_fibonacci_values($value) {
    // fib(2) = 1
    // fib(3) = 2
    $a = 1;
    $b = 2;
    $fibs = array();

    // Get Fibonacci values up to and including specified value
    while ($a <= $value) {
        // fib(n) = fib(n - 1) + fib(n - 2)
        array_push($fibs, $a);
        [$a, $b] = [$b, $a + $b];
    }

    return $fibs;
}

function get_zeckendorf_values($value) {
    $zecks = array();

    // Go through Fibonacci numbers in reverse order, stopping when
    // remaining value is zero
    $fibs = get_fibonacci_values($value);
    for ($n = count($fibs) - 1; $n >=0 && $value > 0;) {
        // If candidate Fibonacci number is greater than or equal to remaining value
        $f = $fibs[$n];
        if ($value >= $f) {
            // Append Fibonacci number to results
            $zecks[] = $f;

            // Reduce remaining value
            $value -= $f;

            // Skip previous value
            $n -= 2;
        } else {
            // Else, go to previous value
            $n--;
        }
    }

    return $zecks;
}

// Exit if too few arguments
if (count($argv) < 2)
{
    usage();
}

// Parse 1st argument. Exit if invalid and negative
$value = parse_int($argv[1]);
if ($value === FALSE || $value < 0) {
    usage();
}

// Get and show Zeckendorf values
$values = get_zeckendorf_values($value);
printf("%s\n", implode(', ', $values));
