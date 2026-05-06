"use strict";

const USAGE = "Usage: please provide a comma-separated list of integers";

const solveMST = (flat, size) => {
  const keys = new Array(size).fill(Infinity);
  const inMST = new Uint8Array(size);

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
};

const run = () => {
  const [, , input] = process.argv;

  if (!input) {
    console.error(USAGE);
    process.exit(1);
  }

  try {
    const flat = input
      .split(",")
      .filter((x) => x.trim() !== "")
      .map((x) => {
        const val = Number(x);
        if (!Number.isInteger(val)) throw new Error();
        return val;
      });

    const size = Math.sqrt(flat.length);

    if (flat.length === 0 || !Number.isInteger(size)) {
      throw new Error();
    }

    const result = solveMST(flat, size);
    console.log(result);
  } catch {
    console.error(USAGE);
    process.exit(1);
  }
};

run();
