<?php
function usage()
{
    exit(
        "Usage: please provide three inputs: a serialized matrix, " .
        "a source node and a destination node"
    );
}

function parse_int($str_value)
{
    // Remove leading and trailing spaces
    $str_value = trim($str_value);

    // Make sure all digits
    if (preg_match("/[+-]?^\d+$/", $str_value) === FALSE)
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

function validate_inputs($weights, $num_vertices, $src, $dest)
{
    // Verify number of weights is a square
    if (count($weights) != $num_vertices * $num_vertices)
    {
        return FALSE;
    }

    // Verify weights greater than equal to zero
    if (min($weights) < 0)
    {
        return FALSE;
    }

    # Verify any non-zero weights
    if (
        count(
            array_filter($weights, function ($weight) { return $weight != 0; })
        ) == 0
    )
    {
        return FALSE;
    }

    # Verify source and destination are in range
    if ($src < 0 or $src >= $num_vertices or $dest < 0 or $dest >= $num_vertices)
    {
        return FALSE;
    }

    return TRUE;
}

function create_graph($weights, $num_vertices)
{
    // Initialize nodes
    $nodes = array_map(
        function ($id) { return new Node($id); },
        range(0, $num_vertices - 1)
    );

    // Get neighbors for this node based on weights
    $index = 0;
    for ($row = 0; $row < $num_vertices; $row++)
    {
        for ($col = 0; $col < $num_vertices; $col++, $index++)
        {
            if ($weights[$index] > 0)
            {
                $nodes[$row]->add_child($col, $weights[$index]);
            }
        }
    }

    return $nodes;
}

class Node
{
    public $index;
    public $children;

    public function __construct($index)
    {
        $this->index = $index;
        $this->children = array();
    }

    public function add_child($index, $weight)
    {
        array_push($this->children, new NodeItem($index, $weight));
    }
}

class NodeItem
{
    public $index;
    public $weight;

    public function __construct($index, $weight)
    {
        $this->index = $index;
        $this->weight = $weight;
    }
}

// Source: https://en.wikipedia.org/wiki/Dijkstra%27s_algorithm#Pseudocode
function dijkstra($graph, $src)
{
    // Initialize distances to infinite and previous vertices to undefined
    // Set source vertex distance to 0
    // Indicate all nodes unvisited
    $num_vertices = count($graph);
    $results = array_map(
        function ($_) { return new DisktraItem(); },
        range(0, $num_vertices - 1)
    );
    $results[$src]->dist = 0;

    // While any unvisited nodes
    for ($i = 0; $i < $num_vertices; $i++)
    {
        // Pick a vertex u with minimum distance from unvisited nodes
        $u = find_min_dist_index($results);

        // Indicate vertex u visited
        $results[$u]->visited = TRUE;

        // For each unvisited neighbor v of vertex u
        foreach ($graph[$u]->children as $node)
        {
            $v = $node->index;
            if (!$results[$v]->visited)
            {
                // Get trial distance
                $alt = $results[$u]->dist + $node->weight;

                // If trial distance is smaller than distance v, update distance to v and
                // previous vertex of v
                if ($alt < $results[$v]->dist)
                {
                    $results[$v]->dist = $alt;
                    $results[$v]->prev = $u;
                }
            }
        }
    }

    return $results;
}

function find_min_dist_index($results)
{
    $min_dist = PHP_INT_MAX;
    $min_index = -1;
    foreach ($results as $v => $result)
    {
        if (!$result->visited && $result->dist < $min_dist)
        {
            $min_dist = $result->dist;
            $min_index = $v;
        }
    }

    return $min_index;
}

class DisktraItem
{
    public $prev;
    public $dist;
    public $visited;

    public function __construct()
    {
        $this->prev = -1;
        $this->dist = PHP_INT_MAX;
        $this->visited = FALSE;
    }
}

// Exit if too few arguments
if (count($argv) < 4)
{
    usage();
}

// Parse arguments. Exit if invalid
$weights = parse_int_array($argv[1]);
$src = parse_int($argv[2]);
$dest = parse_int($argv[3]);
if ($weights === FALSE || $src === FALSE || $dest === FALSE)
{
    usage();
}

// Validate inputs
$num_vertices = round(sqrt(count($weights)));
if (!validate_inputs($weights, $num_vertices, $src, $dest))
{
    usage();
}

// Create graph from weights
$graph = create_graph($weights, $num_vertices);

// Run Dijkstra's algorithm on graph and show distance to destination
$results = dijkstra($graph, $src);
printf("%d\n", $results[$dest]->dist);
