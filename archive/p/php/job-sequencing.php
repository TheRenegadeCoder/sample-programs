<?php

if ($argc < 3 || empty($argv[1]) || empty($argv[2]))
{
    return_error();
}

$profits = parse_int_array($argv[1]);
$deadlines = parse_int_array($argv[2]);

$profits_count = count($profits);
$deadlines_count = count($deadlines);

if ($profits_count < 1 || $profits_count != $deadlines_count)
{
    return_error();
}

$max_deadline = max($deadlines);

$jobsToDo = array_fill(0, $profits_count, 0);

for ($i = 0; $i <= $profits_count; $i++) {
    $job_index = $deadlines[$i] - 1;
    while ($job_index >= 0 && $job_index < $profits_count) {
        if ($jobsToDo[$job_index] == 0) {
            $jobsToDo[$job_index] = $profits[$i];
            break;
        }
        $job_index--;
    }
}

echo array_sum($jobsToDo); 

function parse_int_array($arg) {
    return array_map('intval', explode(',', trim($arg, ',')));
}

function return_error() {
    echo "Usage: please provide a list of profits and a list of deadlines\n";
    exit();
}

?>