"use strict";

const USAGE = "Usage: ./fraction-math operand1 operator operand2";

class Fraction {
  private n: number;
  private d: number;

  constructor(numerator: number, denominator: number) {
    if (denominator === 0) {
      throw new Error("Division by zero");
    }

    const sign = denominator < 0 ? -1 : 1;
    const common = Fraction.gcd(numerator, denominator);

    this.n = (numerator / common) * sign;
    this.d = (denominator / common) * sign;
  }

  static gcd(a: number, b: number): number {
    let x = Math.abs(a);
    let y = Math.abs(b);

    while (y !== 0) {
      const tmp = x % y;
      x = y;
      y = tmp;
    }

    return x;
  }

  static parse(str: string): Fraction {
    const parts = str.split("/");

    const n = parseInt(parts[0], 10);
    const d = parts[1] !== undefined ? parseInt(parts[1], 10) : 1;

    if (isNaN(n) || isNaN(d)) {
      throw new Error("Invalid fraction format");
    }

    return new Fraction(n, d);
  }

  add(o: Fraction): Fraction {
    return new Fraction(this.n * o.d + o.n * this.d, this.d * o.d);
  }

  sub(o: Fraction): Fraction {
    return new Fraction(this.n * o.d - o.n * this.d, this.d * o.d);
  }

  mul(o: Fraction): Fraction {
    return new Fraction(this.n * o.n, this.d * o.d);
  }

  div(o: Fraction): Fraction {
    return new Fraction(this.n * o.d, this.d * o.n);
  }

  compare(o: Fraction): number {
    const diff = this.n * o.d - o.n * this.d;

    if (diff === 0) return 0;
    return diff > 0 ? 1 : -1;
  }

  toString(): string {
    return `${this.n}/${this.d}`;
  }
}

const operators: {
  [key: string]: (a: Fraction, b: Fraction) => Fraction | number;
} = {
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

function run(): void {
  const [, , rawA, op, rawB] = process.argv;

  if (!rawA || !rawB || !op || !(op in operators)) {
    console.error(USAGE);
    process.exit(1);
  }

  try {
    const f1 = Fraction.parse(rawA);
    const f2 = Fraction.parse(rawB);

    const result = operators[op](f1, f2);

    console.log(result.toString());
  } catch {
    console.error(USAGE);
    process.exit(1);
  }
}

run();
