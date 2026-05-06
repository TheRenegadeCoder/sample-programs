function printUsage(): void {
  console.error(
    "Usage: please provide a string that contains at least one palindrome",
  );
  process.exit(1);
}

function preprocess(s: string): string {
  // e.g. "abba" -> "^#a#b#b#a#$"
  return "^#" + s.split("").join("#") + "#$";
}

function longestPalindromicSubstring(s: string): string | null {
  if (!s) return null;

  const T = preprocess(s);
  const n = T.length;
  const P = new Array<number>(n).fill(0);

  let C = 0; // center
  let R = 0; // right boundary

  for (let i = 1; i < n - 1; i++) {
    const mirror = 2 * C - i;

    if (i < R) {
      P[i] = Math.min(R - i, P[mirror]);
    }

    // expand around center i
    while (T[i + 1 + P[i]] === T[i - 1 - P[i]]) {
      P[i]++;
    }

    // update center
    if (i + P[i] > R) {
      C = i;
      R = i + P[i];
    }
  }

  // find max palindrome
  let maxLen = 0;
  let centerIndex = 0;

  for (let i = 1; i < n - 1; i++) {
    if (P[i] > maxLen) {
      maxLen = P[i];
      centerIndex = i;
    }
  }

  if (maxLen === 0) return null;

  const start = (centerIndex - maxLen) >> 1;
  return s.substring(start, start + maxLen);
}

function main(): void {
  const input = process.argv[2];

  if (!input) {
    printUsage();
  }

  const result = longestPalindromicSubstring(input);
  if (!result || result?.length < 2) {
    printUsage();
  }

  console.log(result);
}

main();
