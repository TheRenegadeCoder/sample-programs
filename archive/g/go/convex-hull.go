package main

import (
	"fmt"
	"os"
	"sort"
	"strconv"
	"strings"
)

type Point struct {
	x int
	y int
}

const usage = `Usage: please provide at least 3 x and y coordinates as separate lists (e.g. "100, 440, 210")`

func parseCoordinates(input string) ([]int, error) {
	parts := strings.Split(input, ",")
	nums := make([]int, 0, len(parts))
	for _, p := range parts {
		val, err := strconv.Atoi(strings.TrimSpace(p))
		if err != nil {
			return nil, fmt.Errorf("invalid number %s", p)
		}
		nums = append(nums, val)
	}
	return nums, nil
}

func parsePoints(xArg, yArg string) ([]Point, error) {
	xs, errX := parseCoordinates(xArg)
	ys, errY := parseCoordinates(yArg)

	if errX != nil || errY != nil {
		return nil, fmt.Errorf("failed to parse input coordinates")
	}

	if len(xs) != len(ys) {
		return nil, fmt.Errorf("coordinate count mismatch: x=%d, y=%d", len(xs), len(ys))
	}

	if len(xs) < 3 {
		return nil, fmt.Errorf("at least 3 points are required")
	}

	points := make([]Point, len(xs))
	for i := 0; i < len(xs); i++ {
		points[i] = Point{x: xs[i], y: ys[i]}
	}
	return points, nil
}

func cross(o, a, b Point) int {
	return (a.x-o.x)*(b.y-o.y) - (a.y-o.y)*(b.x-o.x)
}

func convexHull(points []Point) []Point {
	n := len(points)
	if n <= 2 {
		return points
	}

	sort.Slice(points, func(i, j int) bool {
		if points[i].x != points[j].x {
			return points[i].x < points[j].x
		}
		return points[i].y < points[j].y
	})

	unique := points[:0]
	for i := 0; i < len(points); i++ {
		if i == 0 || points[i] != points[i-1] {
			unique = append(unique, points[i])
		}
	}
	points = unique

	if len(points) <= 2 {
		return points
	}

	var hull []Point

	for _, p := range points {
		for len(hull) >= 2 && cross(hull[len(hull)-2], hull[len(hull)-1], p) <= 0 {
			hull = hull[:len(hull)-1]
		}
		hull = append(hull, p)
	}

	lowerLen := len(hull)
	for i := len(points) - 2; i >= 0; i-- {
		p := points[i]
		for len(hull) > lowerLen && cross(hull[len(hull)-2], hull[len(hull)-1], p) <= 0 {
			hull = hull[:len(hull)-1]
		}
		hull = append(hull, p)
	}

	return hull[:len(hull)-1]
}

func main() {
	if len(os.Args) != 3 {
		fmt.Fprintln(os.Stderr, usage)
		os.Exit(1)
	}

	points, err := parsePoints(os.Args[1], os.Args[2])
	if err != nil {
		fmt.Fprintf(os.Stderr, usage)
		os.Exit(1)
	}

	result := convexHull(points)

	for _, p := range result {
		fmt.Printf("(%d, %d)\n", p.x, p.y)
	}
}