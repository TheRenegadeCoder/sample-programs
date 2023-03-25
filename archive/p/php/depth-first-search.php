<?php
function usage()
{
    exit(
        'Usage: please provide a tree in an adjacency matrix form '
        . '("0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0") '
        . 'together with a list of vertex values ("1, 3, 5, 2, 4") '
        . 'and the integer to find ("4")'
);
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

class Node
{
    public $id;
    public $children;

    public function __construct($id)
    {
        $this->id = $id;
        $this->children = array();
    }

    public function add_child(&$node)
    {
        array_push($this->children, $node);
    }
}

function create_tree($adjacency_matrix, $vertices)
{
    // Create nodes
    $nodes = array_map(
        function ($vertex) { return new Node($vertex); },
        $vertices
    );

    // Add child nodes to each node based on non-zero values of adjacency matrix
    $index = 0;
    $num_vertices = count($vertices);
    $num_adjacencies = count($adjacency_matrix);
    for ($row = 0; $row < $num_vertices && $index < $num_adjacencies; $row++)
    {
        for ($col = 0; $col < $num_vertices && $index < $num_adjacencies; $col++, $index++)
        {
            if ($adjacency_matrix[$index])
            {
                $nodes[$row]->add_child($nodes[$col]);
            }
        }
    }

    return $nodes;
}

function depth_first_search($tree, $target)
{
    // Indicate no nodes visited
    $visited = array();

    // Perform depth first recursively starting at root of tree
    return depth_first_search_rec($tree[0], $target, $visited);
}

function &depth_first_search_rec(&$node, $target, &$visited)
{
    $found = NULL;

    // If node is invalid or value of this node matches target, return this node
    if (is_null($node) || $node->id == $target)
    {
        return $node;
    }

    // Indicate this node is visited
    $visited[$node->id] = TRUE;

    // Perform depth first search on each unvisited child of this node (if any).
    // Stop when match is found
    foreach ($node->children as $child)
    {
        if (!array_key_exists($child->id, $visited))
        {
            $found = depth_first_search_rec($child, $target, $visited);
            $visited[$child->id] = TRUE;
            if (!is_null($found))
            {
                break;
            }
        }
    }

    return $found;
}

// Exit if too few arguments
if (count($argv) < 4)
{
    usage();
}

// Parse 1st command line argument. Exit if invalid or too few items
$adjacency_matrix = parse_int_array($argv[1]);
if ($adjacency_matrix === FALSE || count($adjacency_matrix) < 1)
{
    usage();
}

// Parse 2nd command line argument. Exit if invalid or too few items
$vertices = parse_int_array($argv[2]);
if ($vertices === FALSE || count($vertices) < 1)
{
    usage();
}

// Parse 3rd command line argument. Exit if invalid
$target = parse_int($argv[3]);
if ($target === FALSE)
{
    usage();
}

// Create tree
$tree = create_tree($adjacency_matrix, $vertices);

// Run depth first search and indicate if value is found
$node = depth_first_search($tree, $target);
printf("%s\n", (!is_null($node) ? "true" : "false"));
