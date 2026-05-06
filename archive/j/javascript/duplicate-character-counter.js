"use strict";

const USAGE = "Usage: please provide a string";

const isAlphaNum = (c) => /^[a-z0-9]$/i.test(c);

const countDuplicates = (str) => {
  const counts = new Map();

  for (const ch of str) {
    if (isAlphaNum(ch)) {
      counts.set(ch, (counts.get(ch) ?? 0) + 1);
    }
  }

  const duplicates = [];

  for (const [ch, count] of counts) {
    if (count > 1) {
      duplicates.push(`${ch}: ${count}`);
    }
  }

  return duplicates.length > 0
    ? duplicates.join("\n")
    : "No duplicate characters";
};

const run = () => {
  const [, , input] = process.argv;

  if (!input) {
    console.error(USAGE);
    process.exit(1);
  }

  console.log(countDuplicates(input));
};

run();
