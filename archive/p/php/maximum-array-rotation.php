<?php
function usage()
{
    exit('Usage: please provide a list of integers (e.g. "8, 3, 1, 2")');
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

function parse_int_array($str_values)
{
    $str_array = explode(",", $str_values);
    $values = array();
    foreach ($str_array as $str_value)
    {
        $value = parse_int($str_value);
        if ($value === FALSE)
        {
            return FALSE;
        }

        array_push($values, $value);
    }

    return $values;
}


// Find maximum array rotation, max{W(k), k=0..N-1}, where:
//
//     W(k) = sum{i*a[i+k mod N], i=0..N-1}
//
// The value of W(k) can be calculated from W(k-1) as follows:
//
//     W(k) = W(k-1) - S + N*a[k-1]
//
// where:
//
//     S = sum{a[i], i=0..N-1} = sum{a[i+x mod N], i=0..N-1}
//
// where: x is any arbitary value
//
// Proof:
//
// - Set up initial assumption for W(k):
//
//     W(k-1) - S + N*a[k-1] = sum{i*a[i+k-1 mod N], i=0..N-1} - sum{a[i+k-1 mod N}, i=0..N-1} + N*a[k-1]
//
// - Combine the two sums:
//
//     = sum{(i-1)*a[i+k-1 mod N], i=0..N-1} + N*a[k-1]
//
// - Pull out the i=0 term:
//     = -a[k-1] + sum{(i-1)*a[i+k-1 mod N], i=1..N-1} + N*a[k-1]
//
// - Combine the a[k-1] terms:
//
//     = sum{(i-1}*a[i+k-1 mod N], i=1..N-1) + (N-1)*a[k-1]
//
// - Change indexing from i=1..N-1 to 0..N-2:
//
//     = sum{i*a[i+k mod N], i=0..N-2} + (N-1)*a[k-1]
//
// - Bring the i=N-1 term back into the sum since N-1+k mod N equals k-1:
//
//     = sum{i*a[i+k mod N], i=0..N-1}
//
// - The above equals W(k)
function maximum_array_rotation($values)
{
    // Calculate sum and initial array rotation
    $s = array_sum($values);
    $w = 0;
    foreach ($values as $i => $value)
    {
        $w += $i * $value;
    }

    // Initialize maximum array rotation
    $wmax = $w;

    // Adjust array rotation and update maximum
    $n = count($values);
    foreach (array_slice($values, 0, $n - 1) as $value)
    {
        $w += $n * $value - $s;
        $wmax = max($w, $wmax);
    }

    return $wmax;
}

// Exit if too few arguments
if (count($argv) < 2)
{
    usage();
}

// Parse 1st command-line argument. Exit if invalid
$values = parse_int_array($argv[1]);
if ($values === FALSE)
{
    usage();
}

// Calculate maximum array rotation and display
$max_value = maximum_array_rotation($values);
echo "${max_value}\n";
