<?php

/**
 * Create a game of life grid.
 * If no spawn rate is given, an empty grid is generated.
 * @param int width Width
 * @param int height Height
 * @param float spawn_rate Spawn rate (% living vs dead between 0.0 to 1.0)
 * @return array Array of array width x height
 */
function build_grid($width, $height, $spawn_rate=0) {
    $grid = array_fill(0, $height, array_fill(0, $width, FALSE));

    $spawn_rate *= 100;
    for ($y = 0; $y < $height; ++$y) {
        for ($x = 0; $x < $width; ++$x) {
            if (random_int(1, 100) <= $spawn_rate) {
                $grid[$y][$x] = TRUE;
            }
        }
    }

    return $grid;
}

/**
 * Check if the grid contains a cell at the specified location.
 * The function will wrap around edges of the grid, if coordinates are out of bounds.
 * @param array grid The grid to check
 * @param int x X coordinate
 * @param int y Y coordinate
 * @return TRUE if cell found, false otherwise
 */
function contains_cell($grid, $x, $y) {
    $width = count($grid[0]);
    $height = count($grid);

    while ($x < 0) $x += $width;
    while ($y < 0) $y += $height;

    while ($x >= $width) $x -= $width;
    while ($y >= $height) $y -= $height;

    return $grid[$y][$x];
}

/**
 * Count the number of neighbors for the specified cell.
 * The function will wrap around edges of the grid.
 * @param array grid The grid
 * @param int x X coordinate
 * @param int y Y coordinate
 * @return number of neighbors
 */
function neighbor_count($grid, $x, $y) {
    $count = 0;
    if (contains_cell($grid, $x - 1, $y - 1))   ++$count;
    if (contains_cell($grid, $x,     $y - 1))   ++$count;
    if (contains_cell($grid, $x + 1, $y - 1))   ++$count;
    if (contains_cell($grid, $x - 1, $y))       ++$count;
    if (contains_cell($grid, $x + 1, $y))       ++$count;
    if (contains_cell($grid, $x - 1, $y + 1))   ++$count;
    if (contains_cell($grid, $x,     $y + 1))   ++$count;
    if (contains_cell($grid, $x + 1, $y + 1))   ++$count;
    return $count;
}

/**
 * Generate a new grid with the current generation.
 * @param array current_generation Current grid.
 * @return array Two element array, first element count of total live cells,
 *      second element is the newly generated grid.
 */
function next_generation($current_generation) {
    $width = count($current_generation[0]);
    $height = count($current_generation);

    $cell_count = 0;
    $next_generation = build_grid($width, $height);
    for ($y = 0; $y < $height; ++$y) {
        for ($x = 0; $x < $width; ++$x) {
            $neighbors = neighbor_count($current_generation, $x, $y);

            // If alive and 2 or 3 neighbors, keep alive
            if (contains_cell($current_generation, $x, $y)) {
                if ($neighbors == 2 || $neighbors == 3) {
                    $next_generation[$y][$x] = TRUE;
                    ++$cell_count;
                }

            // If dead and exactly 3 neighbors, birth it.
            } else {
                if ($neighbors == 3) {
                    $next_generation[$y][$x] = TRUE;
                    ++$cell_count;
                }
            }
        }
    }

    return array($cell_count, $next_generation);
}

/**
 * Print the generation number and grid to the console.
 * @param int generation The generation number
 * @param array grid The grid
 */
function print_grid($generation, $grid) {
    $width = count($grid[0]);
    $height = count($grid);

    echo "\nGeneration number $generation.\n";
    echo '+', str_repeat('-', $width * 2), "+\n";
    for ($y = 0; $y < $height; ++$y) {
        echo '|';
        for ($x = 0; $x < $width; ++$x) {
            if (contains_cell($grid, $x, $y)) {
                echo ' O';
            } else {
                echo ' .';
            }
        }
        echo "|\n";
    }
    echo '+', str_repeat('-', $width * 2), "+\n";
}

/**
 * Print program usage.
 * @param int exit_code Exit code
 * @param string error_message Error message to display.
 */
function usage($exit_code=0, $error_message=FALSE) {
    echo "Usage: [--width WIDTH] [--frame-rate RATE] [--spawn-rate RATE] [-h | --help] [--total-frames FRAMES]\n\n";
    echo "\t--width WIDTH          with of the grid\n";
    echo "\t--frame-rate RATE      frames per second to display\n";
    echo "\t--spawn-rate RATE      spawn rate, from 0.0 to 1.0\n";
    echo "\t--total-frames FRAMES  total frames to display\n\n";

    if ($error_message) {
        echo "Error: $error_message\n\n";
    }

    exit($exit_code);
}

/**
 * Parse command line arguments.
 * @return array with arguments and values.
 */
function parse_args() {
    global $argc;

    if ($argc == 1) {
        usage(1);
    }

    $defaults = array(
        "width" => 10,
        "frame-rate" => 8,
        "total-frames" => 10,
        "spawn-rate" => 0.10,
    );

    $ops_parsed = getopt("h",
        array("help", "width:", "frame-rate:", "total-frames:", "spawn-rate:"),
        $end_index);

    if (!$ops_parsed) {
        usage(1, "Invalid command line options.");
    }

    if (array_key_exists("h", $ops_parsed) || array_key_exists("help", $ops_parsed)) {
        usage();
    }

    if ($end_index < $argc) {
        usage(1, "Invalid command line options.");
    }

    $options = array_merge($defaults, $ops_parsed);

    if ($options['width'] <= 0) {
        usage(1, "Width must be a positive integer.");
    }

    if ($options['frame-rate'] <= 0) {
        usage(1, "Frame rate must be a positive integer.");
    }

    if ($options['total-frames'] <= 0) {
        usage(1, "Total frames must be a positive integer.");
    }

    if ($options['spawn-rate'] <= 0.0 || $options['spawn-rate'] > 1.0) {
        usage(1, "Spawn rate must be between 0.0 and 1.0 (inclusive).");
    }

    return $options;
}


// Parse and print options
$options = parse_args();
foreach ($options as $op => $val) {
    echo "$op: $val\n";
}

// Display the first generation
$grid = build_grid($options['width'], $options['width'], $options['spawn-rate']);
print_grid(1, $grid);

// Display subsequent generations
for ($i = 1; $i < $options['total-frames']; ++$i) {
    list($cell_count, $grid) = next_generation($grid);
    print_grid($i + 1, $grid);

    if ($cell_count == 0) {
        echo "\nNo more cell alive, stopping at generation ", $i + 1, ".\n";
        break;
    }

    // control frame rate
    usleep(1000000 / $options['frame-rate']);
}

exit(0);

?>
