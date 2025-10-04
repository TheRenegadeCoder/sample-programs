function usage() {
    print "Usage: please provide a comma-separated list of integers"
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

function create_graph(weights, num_vertices, graph,  u, v, idx) {
    idx = 0
    for (u = 0; u < num_vertices; u++) {
        for (v = 0; v < num_vertices; v++) {
            idx++
            if (weights[idx] > 0) {
                graph[u][v] = weights[idx]
            }
        }
    }
}

# Prim's Minimum Spanning Tree (MST) Algorithm based on C implementation of
# https://www.geeksforgeeks.org/prims-minimum-spanning-tree-mst-greedy-algo-5/
function prim_mst(graph, num_vertices, mst,  i, u, v, parents, keys, mst_set, graph_value) {
    # Initialize key values to infinite
    for (i = 0; i < num_vertices; i++) {
        keys[i] = 1e999 # Awk doesn't have infinity, so use large integer
    }

    # Include first vertex in MST
    keys[0] = 0
    parents[0] = -1 # Root has no parent #

    # For each vertex
    for (i = 1; i < num_vertices; i++) {
        # Pick index of the minimum key value not already in MST
        u = find_min_key(keys, mst_set)

        # Add picked vertex to MST set
        mst_set[u] = 1

        # Update key values and parent indices of picked adjacent
        # vertices. Only consider vertices not yet in MST set
        for (v in graph[u]) {
            graph_value = graph[u][v]
            if (!(v in mst_set) && graph_value < keys[v]) {
                parents[v] = u
                keys[v] = graph_value
            }
        }
    }

    # Construct MST information to return, skipping over root
    for (i = 1; i < num_vertices; i++) {
        mst[i]["vertex1"] = parents[i]
        mst[i]["vertex2"] = i
        mst[i]["weight"] = graph[i][parents[i]]
    }
}

function find_min_key(keys, mst_set,  min_key, min_index, v) {
    min_key = 1e999
    min_index = -1
    for (v in keys) {
        if (keys[v] < min_key && !(v in mst_set)) {
            min_key = keys[v]
            min_index = v
        }
    }

    return min_index
}

function get_total_mst_weight(mst,  i, total) {
    total = 0
    for (i in mst) {
        total += mst[i]["weight"]
    }

    return total
}

BEGIN {
    if (ARGC < 2) {
        usage()
    }

    str_to_array(ARGV[1], weights)
    num_weights = length(weights)
    num_vertices = int(sqrt(num_weights) + 0.5)
    if (!num_weights || weights[1] == "ERROR" || \
        num_vertices * num_vertices != num_weights) {
        usage()
    }

    create_graph(weights, num_vertices, graph)
    prim_mst(graph, num_vertices, mst)
    print get_total_mst_weight(mst)
}
