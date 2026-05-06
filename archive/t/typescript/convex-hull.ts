type Point = { x: number; y: number };

function getInputs(xArg?: string, yArg?: string): Point[] | null {
  if (!xArg || !yArg) return null;

  const xParts = xArg.split(",");
  const yParts = yArg.split(",");

  if (xParts.length !== yParts.length || xParts.length < 3) return null;

  const points: Point[] = [];
  for (let i = 0; i < xParts.length; i++) {
    const x = xParts[i].trim();
    const y = yParts[i].trim();

    if (!/^-?\d+$/.test(x) || !/^-?\d+$/.test(y)) return null;

    points.push({ x: Number(x), y: Number(y) });
  }

  return points;
}

const cross = (o: Point, a: Point, b: Point) =>
  (a.x - o.x) * (b.y - o.y) - (a.y - o.y) * (b.x - o.x);

function convexHull(points: Point[]): Point[] {
  if (points.length <= 2) return points;

  points.sort((a, b) => a.x - b.x || a.y - b.y);

  const uniquePoints: Point[] = [];
  for (let i = 0; i < points.length; i++) {
    if (
      i === 0 ||
      points[i].x !== points[i - 1].x ||
      points[i].y !== points[i - 1].y
    ) {
      uniquePoints.push(points[i]);
    }
  }

  if (uniquePoints.length <= 2) return uniquePoints;

  const hull: Point[] = [];

  for (const p of uniquePoints) {
    while (
      hull.length >= 2 &&
      cross(hull[hull.length - 2], hull[hull.length - 1], p) <= 0
    ) {
      hull.pop();
    }
    hull.push(p);
  }

  const lowerHullLength = hull.length;
  for (let i = uniquePoints.length - 2; i >= 0; i--) {
    const p = uniquePoints[i];
    while (
      hull.length > lowerHullLength &&
      cross(hull[hull.length - 2], hull[hull.length - 1], p) <= 0
    ) {
      hull.pop();
    }
    hull.push(p);
  }

  hull.pop();
  return hull;
}

function main(): void {
  const points = getInputs(process.argv[2], process.argv[3]);

  if (!points) {
    console.error(
      'Usage: please provide at least 3 x and y coordinates as separate lists (e.g. "100, 440, 210")',
    );
    process.exit(1);
  }

  convexHull(points!).forEach((p) => console.log(`(${p.x}, ${p.y})`));
}

main();
