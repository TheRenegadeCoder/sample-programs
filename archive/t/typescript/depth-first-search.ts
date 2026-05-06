function printUsage(): void {
  console.log(
    'Usage: please provide a tree in an adjacency matrix form ("0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0") together with a list of vertex values ("1, 3, 5, 2, 4") and the integer to find ("4")',
  );
}

function parseList(input: string): number[] {
  return input
    .split(",")
    .map((x) => x.trim())
    .filter(Boolean)
    .map(Number);
}

function buildMatrix(flat: number[]): number[][] {
  const n = Math.sqrt(flat.length);

  if (!Number.isInteger(n)) {
    throw new Error("Invalid matrix: must be square");
  }

  const matrix: number[][] = [];

  for (let i = 0; i < n; i++) {
    matrix.push(flat.slice(i * n, i * n + n));
  }

  return matrix;
}

function buildAdjList(matrix: number[][]): number[][] {
  const n = matrix.length;
  const adj: number[][] = Array.from({ length: n }, () => []);

  for (let i = 0; i < n; i++) {
    for (let j = 0; j < n; j++) {
      if (matrix[i][j] === 1) {
        adj[i].push(j);
      }
    }
  }

  return adj;
}

class Graph {
  constructor(
    private adj: number[][],
    private values: number[],
  ) {}

  dfs(start: number, target: number): boolean {
    const visited = new Array(this.adj.length).fill(false);

    const visit = (node: number): boolean => {
      if (visited[node]) return false;

      visited[node] = true;

      if (this.values[node] === target) return true;

      for (const next of this.adj[node]) {
        if (visit(next)) return true;
      }

      return false;
    };

    return visit(start);
  }
}

function main(): void {
  const [, , treeInput, valuesInput, targetInput] = process.argv;

  if (!treeInput || !valuesInput || !targetInput) {
    printUsage();
    return;
  }

  try {
    const flatMatrix = parseList(treeInput);
    const values = parseList(valuesInput);
    const target = Number(targetInput);

    const matrix = buildMatrix(flatMatrix);
    const adj = buildAdjList(matrix);

    if (values.length !== matrix.length) {
      throw new Error("Vertex values length does not match matrix size");
    }

    const graph = new Graph(adj, values);
    const found = graph.dfs(0, target);

    console.log(found ? "true" : "false");
  } catch {
    printUsage();
  }
}

main();
