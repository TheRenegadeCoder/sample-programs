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
# of nodes. Each node consists of a vertex value and sequence of child indices.
#
# AWK can't do multi-dimensional arrays or structures, so simulate this by
# using the following indices:
# - <x>, "child", <y> = index for node <x>, child <y>
# - <x>, "num_children" = index for number of children for node <x>
# - <x>, "value" = index for value of node <x>
#
# The commas in the indices mean string concatenation so '1, "child", 2' turns into
# an index of "1child2"
function create_tree(nodes, adjacency_matrix, vertex_values, num_vertex_values, \
    row, num_children, col) {
    idx = 1
    for (row = 1; row <= num_vertex_values; row++) {
        # Store child indices for this node based on non-zero values of adjacency matrix
        num_children = 0
        for (col = 1; col <= num_vertex_values; col++) {
            if (adjacency_matrix[idx]) {
                num_children++
                nodes[row, "child", num_children] = col
            }

            idx++
        }

        # Store number of children for this node
        nodes[row, "num_children"] = num_children

        # Store vertex value for this node
        nodes[row, "value"] = vertex_values[row]
    }
}

function depth_first_search(nodes, target, num_vertex_values, \
    idx, visited, node_idx, sp, stack, found_idx, child_idx) {
    # Indicate all nodes are unvisited
    for (idx = 1; idx <= num_vertex_values; idx++) {
        visited[idx] = 0
    }

    # Do depth first search iteratively using a stack of node indices to try

    # Push root index to stack
    node_idx = 1
    sp = 0
    stack[++sp] = node_idx

    # While stack is not empty
    while (sp > 0) {
        found_idx = 0

        # Pop node index from stack
        node_idx = stack[sp--]

        # If node is invalid or value of this node matches target, return this node index
        if (node_idx == 0 || nodes[node_idx, "value"] == target) {
            found_idx = node_idx
            break
        }

        # Indicate this node is visited
        visited[node_idx] = 1

        # Push all unvisited child indices to the stack
        for (idx = 1; idx <= nodes[node_idx, "num_children"]; idx++) {
            child_idx = nodes[node_idx, "child", idx]
            if (!visited[child_idx]) {
                stack[++sp] = child_idx
            }
        }
    }

    return found_idx
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

    num_vertex_values = length(vertex_values)
    create_tree(nodes, adjacency_matrix, vertex_values, num_vertex_values)
    node_idx = depth_first_search(nodes, target, num_vertex_values)
    print (node_idx > 0) ? "true" : "false"
}
