function printUsage(): void {
  console.error("Usage: please provide a comma-separated list of integers");
  process.exit(1);
}

function solveMST(flat: number[], size: number): number {
  const keys: number[] = new Array(size).fill(Infinity);
  const inMST: Uint8Array = new Uint8Array(size);

  keys[0] = 0;

  for (let count = 0; count < size; count++) {
    let u = -1;

    for (let v = 0; v < size; v++) {
      if (!inMST[v] && (u === -1 || keys[v] < keys[u])) {
        u = v;
      }
    }

    if (u === -1 || keys[u] === Infinity) break;

    inMST[u] = 1;

    const rowOffset = u * size;

    for (let v = 0; v < size; v++) {
      const weight = flat[rowOffset + v];

      if (weight > 0 && !inMST[v] && weight < keys[v]) {
        keys[v] = weight;
      }
    }
  }

  return keys.reduce((sum, w) => (w === Infinity ? sum : sum + w), 0);
}

function parseInput(input: string): number[] {
  return input
    .split(",")
    .map((s) => s.trim())
    .filter((s) => s.length > 0)
    .map((s) => {
      const val = Number(s);
      if (!Number.isInteger(val)) throw new Error("invalid");
      return val;
    });
}

function main(): void {
  const input = process.argv[2];

  if (!input) {
    printUsage();
  }

  try {
    const flat = parseInput(input);
    const size = Math.sqrt(flat.length);

    if (flat.length === 0 || !Number.isInteger(size)) {
      throw new Error("invalid size");
    }

    const result = solveMST(flat, size);
    console.log(result);
  } catch {
    printUsage();
  }
}

main();
