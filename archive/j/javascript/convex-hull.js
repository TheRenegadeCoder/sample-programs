function ccw(p1, p2, p3) {
  let result = (p3[0] - p2[0]) * (p1[1] - p2[1]) - (p3[1] - p2[1]) * (p1[0] - p2[0]);
  return result;
}

function distance_sqrt(p, q) {
  return (p[1] - q[1]) * (p[1] - q[1]) + (p[0] - q[0]) * (p[0] - q[0]);
}

function ccw_compare(p1, p2, pivot) {
  let isccw = ccw(pivot, p1, p2);
  if (isccw === 0) {
    return distance_sqrt(p2, pivot) - distance_sqrt(p1, pivot)
  }
  return -isccw;
}

function ccw_sort(points) {
  // find pivot and remove from array
  let pivot = points[0];
  let pivot_index = 0;
  for (let i = 1; i < points.length; i++) {
    if (points[i][0] < pivot[0]) {
      pivot = points[i];
      pivot_index = i;
    } else if (points[i][0] === pivot[0] && points[i][1] < pivot[1]) {
      pivot = points[i];
      pivot_index = i;
    }
  }
  points.splice(pivot_index, 1);
  // sort points
  points.sort((p1, p2) => ccw_compare(p1, p2, pivot));
  // return list of sorted points with pivot first
  return [pivot, ...points, pivot];
}

function convex_hull(points) {
  // 1.- Sort list of points
  points = ccw_sort(points);
  // 2.- Run Graham scan algorithm
  const hull = [];
  points.forEach(p => {
    while (hull.length > 1 && ccw(hull[1], hull[0], p) <= 0) {
      hull.shift();
    }
    hull.unshift(p);
  });
  hull.shift();
  return hull.reverse();
}


const input_x = process.argv[2];
const input_y = process.argv[3];

const array_x = input_x.split(' ').map(x => parseInt(x, 10));
const array_y = input_y.split(' ').map(y => parseInt(y, 10));

if (array_x.length !== array_y.length) {
  console.log('Usage:\nnode convex-hull.js "x1 x2 x3 ... xN" "y1 y2 y3 ... yN"');
  return;
}

const points = array_x.map((x, idx) => [x, array_y[idx]]);
const convexHull = convex_hull(points);

convexHull.forEach(p => {
  console.log(`(${p[0]}, ${p[1]})`);
});
return;