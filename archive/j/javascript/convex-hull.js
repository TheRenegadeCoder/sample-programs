/**
 * Calculate the Convex Hull of a set of 2D points using Graham's Scan algorithm.
 *
 * @param {Array} points - An array of 2D points represented as objects with x and y properties.
 * @returns {Array} - An array of points on the convex hull in counter-clockwise order.
 */
function convexHull(points) {
	function orientation(p, q, r) {
		const val = (q.y - p.y) * (r.x - q.x) - (q.x - p.x) * (r.y - q.y)
		if (val === 0) return 0
		return val > 0 ? 1 : -1
	}

	const n = points.length
	if (n < 3) return points

	let minPointIndex = 0
	for (let i = 0; i < n; i++) {
		if (
			(points[i].y < points[minPointIndex].y) ||
			(points[i].y == points[minPointIndex].y && points[i].x < points[minPointIndex].x)
		) {
			minPointIndex = i
		}
	}
	const sortedPoints = [...points].sort((a, b) => {
		const angleA = Math.atan2(a.y - points[minPointIndex].y, a.x - points[minPointIndex].x)
		const angleB = Math.atan2(b.y - points[minPointIndex].y, b.x - points[minPointIndex].x)
		return angleA - angleB
	})

	const convexHull = [sortedPoints[0], sortedPoints[1]]

	for (let i = 2; i < n; i++) {
		while (
			convexHull.length > 1 &&
			orientation(
				convexHull[convexHull.length - 2],
				convexHull[convexHull.length - 1],
				sortedPoints[i]
			) !== -1
		) {
			convexHull.pop()
		}
		convexHull.push(sortedPoints[i])
	}

	return convexHull
}

/**
 * Executable function for Convex Hull calculation with command-line input.
 *
 * @param {string} inputX - Comma-separated X coordinates as a string.
 * @param {string} inputY - Comma-separated Y coordinates as a string.
 */
function main(inputX, inputY) {
	if (inputX == undefined || inputY == undefined){
		inputX = " "
		inputY = " "
	}
	const xArray = inputX.split(",").map(Number)
	const yArray = inputY.split(",").map(Number)

	if (
		xArray.length < 3 ||
		yArray.length < 3 ||
		xArray.length !== yArray.length ||
		xArray.some(item => isNaN(item))|| yArray.some(item => isNaN(item))
	) {
		console.log(
			'Usage: please provide at least 3 x and y coordinates as separate lists (e.g. "100, 440, 210")'
		)
		return
	}

	const points = xArray.map((x, i) => ({ x, y: yArray[i] }))

	const convexHullResult = convexHull(points)
	convexHullResult.forEach((point) => console.log(`(${point.x}, ${point.y})`))
}

// Run the executable function with command-line arguments
const inputX = process.argv[2]
const inputY = process.argv[3]
main(inputX, inputY)
