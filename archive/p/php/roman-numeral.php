<?php

/**
 * Roman numeral string to Decimal value.
 * @param string $romans String to convert.
 * @return int The decimal value.
 * @throws Exception on invalid roman string.
 */
function roman_to_decimal($romans)
{
    // conversion table
    $roman_values = array("I" => 1, "V" => 5, "X" => 10,
        "L" => 50, "C" => 100, "D" => 500, "M" => 1000);

    $total = 0;
    $previous = 0;

    // parse from end to start of string
    for ($i = strlen($romans) - 1; $i >= 0; --$i) {

        // check if the character is a roman numeral
        $numeral = strtoupper($romans[$i]);
        if (!array_key_exists($numeral, $roman_values)) {
            throw new Exception("invalid string of roman numerals");
        }

        // convert to decimal and add/subtract from total.
        $value = $roman_values[$numeral];
        if ($value >= $previous) {
            $total += $value;

        } else {
            $total -= $value;
        }

        // keep track of last value
        $previous = $value;
    }

    return $total;
}

try {

    // Check argument count
    if ($argc < 2) {
        echo "Usage: please provide a string of roman numerals\n";
        exit(1);
    }

    // Convert the string
    echo roman_to_decimal($argv[1]), "\n";
    exit(0);

} catch (Exception $e) {
    echo "Error: ", $e->getMessage(), "\n";
    exit(1);
}
