function usage() {
    print "Usage: please provide three inputs: a serialized matrix, a source node and a destination node"
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

function validate_inputs(weights, num_weights, num_vertices, src, dest,  i, any_non_zero) {
    # Verify number of weights is a square, source and destination are valid
    if (num_weights != num_vertices * num_vertices || \
        src < 0 || src >= num_vertices || \
        dest < 0 || dest >= num_vertices) {
        return 0
    }

    # Verify weights greater than equal to zero and at any non-zero weights
    any_non_zero = 0
    for (i = 1; i <= num_weights; i++) {
        if (weights[i] < 0) {
            return 0
        }

        if (weights[i] > 0) {
            any_non_zero = 1
        }
    }

    return any_non_zero
}

function create_graph(weights, num_vertices, graph,  u, v, idx, num_edges) {
    idx = 0
    for (u = 1; u <= num_vertices; u++) {
        num_edges = 0
        for (v = 1; v <= num_vertices; v++) {
            idx++
            if (weights[idx] > 0) {
                num_edges++
                graph[u, num_edges]["vertex"] = v
                graph[u, num_edges]["weight"] = weights[idx]
            }

            graph[u, "num_edges"] = num_edges
        }
    }
}

BEGIN {
    if (ARGC < 4) {
        usage()
    }

    str_to_array(ARGV[1], weights)
    num_weights = length(weights)
    src = str_to_number(ARGV[2])
    dest = str_to_number(ARGV[3])
    if (!num_weights || weights[1] == "ERROR" || src == "ERROR" || dest == "ERROR") {
        usage()
    }

    num_vertices = int(sqrt(num_weights) + 0.5)
    if (!validate_inputs(weights, num_weights, num_vertices, src, dest)) {
        usage()
    }

    create_graph(weights, num_vertices, graph)
    for (u = 1; u <= num_vertices; u++) {
        for (i = 1; i <= graph[u, "num_edges"]; i++) {
            printf("%d -> %d (%d)\n", u - 1, graph[u, i]["vertex"] - 1, graph[u, i]["weight"])
        }
    }
}
