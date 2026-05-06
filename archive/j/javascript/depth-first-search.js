"use strict";

const USAGE =
  'Usage: please provide a tree in an adjacency matrix form ("0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0") together with a list of vertex values ("1, 3, 5, 2, 4") and the integer to find ("4")';

/**
 * Parses a comma-separated string into an array of numbers.
 */
const parseNumbers = (str) =>
  str
    .split(",")
    .filter((val) => val.trim() !== "")
    .map(Number);

/**
 * Transforms a flat array into a 2D adjacency matrix.
 */
const buildMatrix = (flatArray) => {
  const size = Math.sqrt(flatArray.length);

  if (!Number.isInteger(size)) {
    throw new Error("Invalid matrix: must be a perfect square.");
  }

  return Array.from({ length: size }, (_, i) =>
    flatArray.slice(i * size, (i + 1) * size),
  );
};

const dfs = (matrix, vertexValues, target) => {
  const visited = new Set();

  const search = (currentIndex) => {
    if (visited.has(currentIndex)) return false;
    visited.add(currentIndex);

    if (vertexValues[currentIndex] === target) return true;

    for (const [neighborIndex, isConnected] of matrix[currentIndex].entries()) {
      if (isConnected === 1 && search(neighborIndex)) {
        return true;
      }
    }

    return false;
  };

  return matrix.length > 0 ? search(0) : false;
};

const run = () => {
  const [, , rawMatrix, rawValues, rawTarget] = process.argv;

  if (!rawMatrix || !rawValues || !rawTarget) {
    console.error(USAGE);
    process.exit(1);
  }

  try {
    const flatMatrix = parseNumbers(rawMatrix);
    const vertexValues = parseNumbers(rawValues);
    const target = Number(rawTarget);

    const matrix = buildMatrix(flatMatrix);

    if (vertexValues.length !== matrix.length) {
      throw new Error("Vertex value count does not match matrix dimensions.");
    }

    const result = dfs(matrix, vertexValues, target);
    console.log(result);
  } catch (_) {
    console.error(USAGE);
    process.exit(1);
  }
};

run();
