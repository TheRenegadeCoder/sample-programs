"use strict";

const USAGE = "Usage: ./fraction-math operand1 operator operand2";

class Fraction {
  #n;
  #d;

  constructor(numerator, denominator) {
    if (denominator === 0n) throw new Error("Division by zero");

    const sign = denominator < 0n ? -1n : 1n;
    const common = Fraction.#gcd(numerator, denominator);

    this.#n = (numerator / common) * sign;
    this.#d = (denominator / common) * sign;
  }

  static #gcd(a, b) {
    let x = a < 0n ? -a : a;
    let y = b < 0n ? -b : b;
    while (y) {
      x %= y;
      [x, y] = [y, x];
    }
    return x;
  }

  static parse(str) {
    const [num, den] = str.split("/");
    try {
      const n = BigInt(num);
      const d = den !== undefined ? BigInt(den) : 1n;
      return new Fraction(n, d);
    } catch {
      throw new Error(`Invalid fraction format: ${str}`);
    }
  }

  add(o) {
    return new Fraction(this.#n * o.#d + o.#n * this.#d, this.#d * o.#d);
  }
  sub(o) {
    return new Fraction(this.#n * o.#d - o.#n * this.#d, this.#d * o.#d);
  }
  mul(o) {
    return new Fraction(this.#n * o.#n, this.#d * o.#d);
  }
  div(o) {
    return new Fraction(this.#n * o.#d, this.#d * o.#n);
  }

  compare(o) {
    const diff = this.#n * o.#d - o.#n * this.#d;
    return diff === 0n ? 0 : diff > 0n ? 1 : -1;
  }

  toString() {
    return `${this.#n}/${this.#d}`;
  }
}

const operators = {
  "+": (a, b) => a.add(b),
  "-": (a, b) => a.sub(b),
  "*": (a, b) => a.mul(b),
  "/": (a, b) => a.div(b),
  "==": (a, b) => (a.compare(b) === 0 ? 1 : 0),
  "!=": (a, b) => (a.compare(b) !== 0 ? 1 : 0),
  ">": (a, b) => (a.compare(b) > 0 ? 1 : 0),
  "<": (a, b) => (a.compare(b) < 0 ? 1 : 0),
  ">=": (a, b) => (a.compare(b) >= 0 ? 1 : 0),
  "<=": (a, b) => (a.compare(b) <= 0 ? 1 : 0),
};

const run = () => {
  const [, , rawA, op, rawB] = process.argv;

  if (!rawA || !op || !rawB || !operators[op]) {
    console.error(USAGE);
    process.exit(1);
  }

  try {
    const f1 = Fraction.parse(rawA);
    const f2 = Fraction.parse(rawB);

    const result = operators[op](f1, f2);
    console.log(result.toString());
  } catch (err) {
    console.error(USAGE);
    process.exit(1);
  }
};

run();
