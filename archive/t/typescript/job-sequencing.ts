type Job = { profit: number; deadline: number };

class DSU {
  parent: number[];

  constructor(size: number) {
    this.parent = Array.from({ length: size + 1 }, (_, i) => i);
  }

  find(x: number): number {
    if (this.parent[x] !== x) {
      this.parent[x] = this.find(this.parent[x]);
    }
    return this.parent[x];
  }

  occupy(x: number): void {
    this.parent[x] = this.find(x - 1);
  }
}

function createJobs(profits: number[], deadlines: number[]): Job[] {
  return profits.map((profit, i) => ({ profit, deadline: deadlines[i] }));
}

function sortJobs(jobs: Job[]): Job[] {
  return [...jobs].sort((a, b) => b.profit - a.profit);
}

function findMaxDeadline(jobs: Job[]): number {
  return jobs.reduce((max, j) => Math.max(max, j.deadline), 0);
}

function findMaxProfit(jobs: Job[]): number {
  const maxDeadline = findMaxDeadline(jobs);
  const dsu = new DSU(maxDeadline);

  let profit = 0;

  for (const job of jobs) {
    const availableSlot = dsu.find(Math.min(job.deadline, maxDeadline));

    if (availableSlot > 0) {
      profit += job.profit;
      dsu.occupy(availableSlot);
    }
  }

  return profit;
}

function parseList(input: string): number[] {
  return input
    .split(",")
    .map((s) => Number(s.trim()))
    .filter((n) => !Number.isNaN(n));
}

function validate(profits: number[], deadlines: number[]): void {
  if (profits.length !== deadlines.length || profits.length === 0) {
    throw new Error("Invalid input");
  }
}

function printUsage(): void {
  console.error(
    "Usage: please provide a list of profits and a list of deadlines",
  );
  process.exit(1);
}

function main(): void {
  const [, , profitInput, deadlineInput] = process.argv;

  if (!profitInput || !deadlineInput) {
    printUsage();
  }

  try {
    const profits = parseList(profitInput);
    const deadlines = parseList(deadlineInput);

    validate(profits, deadlines);

    const jobs = sortJobs(createJobs(profits, deadlines));
    console.log(findMaxProfit(jobs));
  } catch {
    printUsage();
  }
}

main();
