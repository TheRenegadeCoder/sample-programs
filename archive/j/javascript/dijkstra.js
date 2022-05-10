const mat = process.argv[2];
const src = parseInt(process.argv[3]);
const des = parseInt(process.argv[4]);

if (!des) {
    if (!src) {
        if (!mat) {
            // No Input / Empty Input
            return console.log(
                "Usage: please provide a comma-separated list of integers"
            );
        }
        // No Source and Destination
        return console.log("Usage: please provide source and destination");
    }
    // No Destination
    return console.log("Usage: please provide a destination");
}

const matList = mat.split(", ");
const len = matList.length;
const n = Math.sqrt(len);

// Non-Square Input
if (n * n != len) {
    return console.log(
        "Usage: please provide a comma-separated list of integers"
    );
}

// The Source or The Destination < 0
if (src < 0 || des < 0) {
    return console.log("Usage: please provide positive node number");
}

// Weight < 0
matList.forEach((weight) => {
    if (weight < 0) {
        return console.log("Usage: please provide positive weights");
    }
});

// The Source or The Destination > SquareRootOfMatrix - 1
if (src > n - 1 || des > n - 1) {
    return console.log("Usage: please provide a node number in the Graph");
}

const mapping = [];
while (matList.length) {
    mapping.push(matList.splice(0, n).map((i) => parseInt(i)));
}

const dijkstra = (src, des, n) => {
    // Create a priority queue to store nodes that
    // are being preprocessed.
    const q = [];

    // Create an array for distances and initialize all
    // distances as infinite (Infinity)
    const dist = new Array(n).fill(Infinity);

    // Insert source itself in priority queue and initialize
    // its distance as 0.
    // A node is a tuple with [id, cost]
    q.push([src, 0]);
    dist[src] = 0;

    while (q.length) {
        let cur = q[0];
        q.shift();
        let u = cur[0];
        let cost = cur[1];

        // Get all adjacent of u.
        for (let i = 0; i < n; i++) {
            let v = mapping[u][i];
            if (v == 0) continue;

            // If there is shorter path to v through u.
            if (cost + v < dist[i]) {
                // Updating distance of v
                dist[i] = cost + v;
                q.push([i, dist[i]]);
            }
        }
    }
    return dist[des];
};

console.log(dijkstra(src, des, n));
