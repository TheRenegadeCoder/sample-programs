<?php
function usage()
{
    exit("Usage: please provide a comma-separated list of integers");
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

// Prim's Minimum Spanning Tree (MST) Algorithm based on C implementation of
// https://www.geeksforgeeks.org/prims-minimum-spanning-tree-mst-greedy-algo-5/
function prim_mst(&$graph)
{
    $num_vertices = count($graph);

    // Array to store constructed MST. Indicate no parents yet
    $parents = array_fill(0, $num_vertices, -1);

    // Key values used to pick minimum weight edge. Initialize to infinity
    $keys = array_fill(0, $num_vertices, PHP_INT_MAX);

    // Indicate nothing in MST yet
    $mst_set = array_fill(0, $num_vertices, FALSE);

    // Include first vertex in MST
    $keys[0] = 0;

    // The MST will include all vertices
    for ($i = 1; $i < $num_vertices; $i++)
    {
        // Pick index of the minimum key value not already in MST
        $u = find_min_key($keys, $mst_set);

        // Add picked vertex to MST
        $mst_set[$u] = TRUE;

        // Update key values and parent indices of picked adjacent
        // vertices. Only consider vertices not yet in MST
        foreach ($graph[$u]->children as $child)
        {
            $v = $child->index;
            $graph_value = $child->weight;
            if (!$mst_set[$v] && $graph_value < $keys[$v])
            {
                $parents[$v] = $u;
                $keys[$v] = $graph_value;
            }
        }
    }

    // Construct MST information to return, skipping over root
    $mst = array();
    for ($i = 1; $i < $num_vertices; $i++)
    {
        array_push($mst, new MSTItem($parents[$i], $i, $keys[$i]));
    }

    return $mst;
}

class MSTItem
{
    public $src_index;
    public $dest_index;
    public $weight;

    function __construct($src_index, $dest_index, $weight)
    {
        $this->src_index = $src_index;
        $this->dest_index = $dest_index;
        $this->weight = $weight;
    }
}

// Find vertex with minimum key values not already in MST
function find_min_key($keys, $mst_set)
{
    $min_value = PHP_INT_MAX;
    $min_index = -1;
    foreach ($keys as $v => $key_value)
    {
        if ($key_value < $min_value && !$mst_set[$v])
        {
            $min_value = $key_value;
            $min_index = $v;
        }
    }

    return $min_index;
}

// Get total MST weight
function get_total_mst_weight($mst)
{
    return array_sum(
        array_map(
            function ($mst_item) { return $mst_item->weight; },
            $mst
        )
    );
}

// Exit if too few arguments
if (count($argv) < 2)
{
    usage();
}

// Parse 1st argument. Exit if invalid
$weights = parse_int_array($argv[1]);
if ($weights === FALSE)
{
    usage();
}

// Exit if number of weight is not a square
$num_weights = count($weights);
$num_vertices = round(sqrt($num_weights));
if ($num_weights != $num_vertices * $num_vertices)
{
    usage();
}

// Create graph from weights
$graph = create_graph($weights, $num_vertices);

// Get MST using Prim's algorithm
$mst = prim_mst($graph);

// Calculate total weight of MST and display
$total_weight = get_total_mst_weight($mst);
echo "${total_weight}\n";
