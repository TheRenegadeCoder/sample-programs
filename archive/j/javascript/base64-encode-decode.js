#!/usr/bin/env node

function usageAndExit() {
  console.error("Usage: please provide a mode and a string to encode/decode");
  process.exit(1);
}

function isValidBase64(str) {
  // Check length multiple of 4
  if (str.length % 4 !== 0) return false;
  // Only A–Z, a–z, 0–9, +, /, = allowed
  if (!/^[A-Za-z0-9+/]*={0,2}$/.test(str)) return false;
  // = only allowed at end, at most two
  const idx = str.indexOf("=");
  if (idx !== -1 && idx < str.length - 2) {
    // e.g. “ab==cd” invalid
    return false;
  }
  return true;
}

function encodeBase64(input) {
  // Use Buffer in Node.js
  return Buffer.from(input, "ascii").toString("base64");
}

function decodeBase64(input) {
  // Validate first
  if (!isValidBase64(input)) {
    usageAndExit();
  }
  // Buffer will ignore invalid trailing bits
  return Buffer.from(input, "base64").toString("ascii");
}

function main() {
  const args = process.argv.slice(2);
  if (args.length < 2) {
    usageAndExit();
  }
  const mode = args[0];
  const text = args[1];

  if (!text) {
    usageAndExit();
  }

  if (mode === "encode") {
    console.log(encodeBase64(text));
  } else if (mode === "decode") {
    console.log(decodeBase64(text));
  } else {
    usageAndExit();
  }
}

if (require.main === module) {
  main();
}

