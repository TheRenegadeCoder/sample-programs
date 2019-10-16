<?php

/**
 * Function to determine if a number if prime.
 * @param int positive integer.
 * @return True if the number is prime, False otherwise.
 */
function is_prime($num) {
    if (($num % 2 == 0 && $num != 2) || ($num == 1)) {
        return FALSE;
    }

    $found_factor = FALSE;
    for ($n = 3; $n <= intval(ceil(sqrt($num))); ++$n) {
        if (($num % $n) == 0) {
            $found_factor = TRUE;
            break;
        }
    }

    return !$found_factor;
}


// Unit Tests (needs 'zend.assertions=1' in php.ini, otherwise ignored)
assert(is_prime(0) === FALSE);
assert(is_prime(1) === FALSE);
assert(is_prime(2) === TRUE);
assert(is_prime(3) === TRUE);
assert(is_prime(4) === FALSE);
assert(is_prime(5) === TRUE);
assert(is_prime(6) === FALSE);
assert(is_prime(7) === TRUE);
assert(is_prime(8) === FALSE);
assert(is_prime(9) === FALSE);
assert(is_prime(10) === FALSE);
assert(is_prime(11) === TRUE);
assert(is_prime(58) === FALSE);
assert(is_prime(59) === TRUE);
assert(is_prime(60) === FALSE);
assert(is_prime(61) === TRUE);
assert(is_prime(4011) === FALSE);
assert(is_prime(3727) === TRUE);


// Check argument
if ($argc < 2 || !is_numeric($argv[1]) || strpos($argv[1], '.') !== FALSE || strpos($argv[1], '-') !== FALSE) {
    echo "Usage: please input a non-negative integer\n";
    exit(1);
}

// Convert the string
if (is_prime(intval($argv[1]))) {
    echo "Prime\n";

} else {
    echo "Composite\n";
}

exit(0);

?>
