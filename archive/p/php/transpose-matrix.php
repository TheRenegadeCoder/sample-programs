<?php
function usage()
{
    exit("Usage: please enter the dimension of the matrix and the serialized matrix");
}

function parse_int($str_value)
{
    // Remove leading and trailing spaces
    $str_value = trim($str_value);

    // Make sure all digits
    if (preg_match("/^\d+$/", $str_value) === FALSE)
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

// Convert list to matrix
function convert_list_to_matrix($values, $num_cols)
{
    return array_chunk($values, $num_cols);
}

// Transpose matrix
function transpose_matrix($matrix)
{
    // Get number of rows.
    // If 1, use 'array_chunk' to output each value in the row to its own row.
    // Otherwise, use 'array_map' with no function and the "splat" operator to
    // output one value in each column and append it to each row
    return (count($matrix) == 1) ? array_chunk($matrix[0], 1) : array_map(NULL, ...$matrix);
}

// Show matrix as a list
function show_matrix_as_list($matrix)
{
    // Join each row value with a comma for each column value
    printf(
        "%s\n",
        implode(", ", array_map(
            function ($value) { return implode(", ", $value); },
            $matrix)
        )
    );
}

// Exit if too few arguments
if (count($argv) < 4)
{
    usage();
}

// Parse 1st argument. Exit if invalid or less than 1
$num_cols = parse_int($argv[1]);
if ($num_cols === FALSE || $num_cols < 1)
{
    usage();
}

// Parse 2nd argument. Exit if invalid or less than 1
$num_rows = parse_int($argv[2]);
if ($num_rows === FALSE || $num_rows < 1)
{
    usage();
}

// Parse 3nd argument. Exit if invalid if incorrect size
$values = parse_int_array($argv[3]);
if ($values == FALSE || count($values) != $num_rows * $num_cols)
{
    usage();
}

// Convert list to matrix
$matrix = convert_list_to_matrix($values, $num_cols);

// Transpose matrix
$matrix_t = transpose_matrix($matrix);

// Show matrix as a list
show_matrix_as_list($matrix_t);
