<?php

/**
 * Roman numeral string to Decimal value.
 * @param string $romans String to convert.
 * @return int The decimal value.
 * @throws Exception on invalid roman string.
 */
function roman_to_decimal($romans) {
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

// Unit Tests (needs 'zend.assertions=1' in php.ini, otherwise ignored)
// Easy values
assert(roman_to_decimal("") === 0);
assert(roman_to_decimal("I") === 1);
assert(roman_to_decimal("V") === 5);
assert(roman_to_decimal("X") === 10);
assert(roman_to_decimal("L") === 50);
assert(roman_to_decimal("C") === 100);
assert(roman_to_decimal("D") === 500);
assert(roman_to_decimal("M") === 1000);

// Bad string
try {
    roman_to_decimal("XT");
    assert(false, "Expecting parsing error");
} catch (Exception $e) { /* OK */ }

// Complex values
assert(roman_to_decimal("XIV") === 14);
assert(roman_to_decimal("XXV") === 25);
assert(roman_to_decimal("CMI") === 901);
assert(roman_to_decimal("MIC") === 1099);
assert(roman_to_decimal("MDCLXVI") === 1666);
assert(roman_to_decimal("MDCCCLXXXVIII") === 1888);
assert(roman_to_decimal("MCMXC") === 1990);
assert(roman_to_decimal("MCMXCIX") === 1999);
assert(roman_to_decimal("MMVIII") === 2008);
assert(roman_to_decimal("MMXII") === 2012);
assert(roman_to_decimal("MMXIX") === 2019);
assert(roman_to_decimal("MMMDCCCLXXXVIII") === 3888);
assert(roman_to_decimal("MMMCMXCV") === 3995);


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
    exit (1);
}

?>
