function usage() {
    print "Usage: please provide a tree in an adjacency matrix form " \
        "(\"0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0\") " \
        "together with a list of vertex values (\"1, 3, 5, 2, 4\") " \
        "and the integer to find (\"4\")"
    exit(1)
}

function str_to_number(s) {
    return (s ~ /^\s*[+-]*[0-9]+\s*$/) ? s + 0 : "ERROR"
}

function str_to_array(s, arr,  str_arr, idx, result) {
    split(s, str_arr, ",")
    for (idx in str_arr) {
        result = str_to_number(str_arr[idx])
        if (result == "ERROR") {
            delete arr
            arr[1] = "ERROR"
            break
        } else {
            arr[idx] = result
        }
    }
}

# Create tree from adjacency matrix and vertex values. The tree consists of a sequence
# of nodes. Each node consists a node value and of child vertex values
function create_tree(nodes, adjacency_matrix, vertex_values,  u, v, node_value) {
    idx = 0
    for (u in vertex_values) {
        # Store node value
        node_value = vertex_values[u]
        nodes[node_value][node_value] = 1

        # Store child indices for this node based on non-zero values of adjacency matrix
        num_children = 0
        for (v in vertex_values) {
            if (adjacency_matrix[++idx]) {
                nodes[node_value][vertex_values[v]] = 1
            }
        }
    }
}

function depth_first_search(nodes, target, \
    value, visited, node_value, sp, stack, found, child_value) {
    # Get root node value
    for (value in nodes) {
        node_value = value
        break
    }

    # Do depth first search iteratively using a stack of node values to try

    # Push root index to stack
    sp = 0
    stack[++sp] = node_value

    # While stack is not empty
    while (sp > 0) {
        found = 0

        # Pop node index from stack
        node_value = stack[sp--]

        # If node is invalid or value of this node matches target, return this node index
        if (node_value == target) {
            found = 1
            break
        }

        # Indicate this node is visited
        visited[node_value] = 1

        # Push all unvisited child indices to the stack
        for (child_value in nodes[node_value]) {
            if (!(child_value in visited)) {
                stack[++sp] = child_value
            }
        }
    }

    return found
}

BEGIN {
    if (ARGC < 4) {
        usage()
    }

    str_to_array(ARGV[1], adjacency_matrix)
    str_to_array(ARGV[2], vertex_values)
    target = str_to_number(ARGV[3])
    if (!length(adjacency_matrix) || adjacency_matrix[1] == "ERROR" || \
        !length(vertex_values) || vertex_values[1] == "ERROR" || \
        target == "ERROR") {
        usage()
    }

    create_tree(nodes, adjacency_matrix, vertex_values)
    found = depth_first_search(nodes, target)
    print (found) ? "true" : "false"
}
