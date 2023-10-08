// Convex Hull Algorithm



function orient(p, q, r) {
	const val = (q[1] - p[1]) * (r[0] - q[0]) - (q[0] - p[0]) * (r[1] - q[1])
	if (val === 0) {
		return 0
	}
	return val > 0 ? 1 : 2
}

function grahamScan(points) {
	const n = points.length

	if (n < 3) {
		return null
	}

	const pivot = points.reduce(
		(min, point) =>
			point[1] < min[1] || (point[1] === min[1] && point[0] < min[0])
				? point
				: min,
		points[0]
	)

	const sortedPoints = points.slice().sort((a, b) => {
		const angleA = Math.atan2(a[1] - pivot[1], a[0] - pivot[0])
		const angleB = Math.atan2(b[1] - pivot[1], b[0] - pivot[0])
		return angleA - angleB
	})

	const hull = [sortedPoints[0], sortedPoints[1]]

	for (let i = 2; i < n; i++) {
		while ( hull.length > 1 && orient(hull[hull.length - 2],hull[hull.length - 1],sortedPoints[i]) !== 2) {
			hull.pop()
		}
		hull.push(sortedPoints[i])
	}

	return hull
}

// Main funciton of the program

function main(){

// sample input
	const points = [
		[0, 0],
		[1, 1],
		[2, 2],
		[2, 0],
		[2, 3],
		[3, 2],
	]
	const convexHull = grahamScan(points)
	console.log(convexHull) //[ [ 0, 0 ], [ 2, 0 ], [ 3, 2 ], [ 2, 3 ] ]
}
main();
