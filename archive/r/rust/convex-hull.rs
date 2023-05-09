use std::env::args;
use std::process::exit;
use std::str::FromStr;
use std::fmt;

fn usage() -> ! {
    println!(
        "Usage: please provide at least 3 x and y coordinates as separate lists \
        (e.g. \"100, 440, 210\")"
    );
    exit(0);
}

fn parse_int<T: FromStr>(s: &str) -> Result<T, <T as FromStr>::Err> {
    s.trim().parse::<T>()
}

fn parse_int_list<T: FromStr>(s: &str) -> Result<Vec<T>, <T as FromStr>::Err> {
    s.split(',')
        .map(parse_int)
        .collect::<Result<Vec<T>, <T as FromStr>::Err>>()
}

#[derive(Clone, Copy)]
struct Point {
    x: i32,
    y: i32,
}

impl Point {
    fn new(x: i32, y: i32) -> Self {
        Self {x: x, y: y}
    }
}

impl fmt::Debug for Point {
    // Show point
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "({}, {})", self.x, self.y)
    }
}

fn form_points(x_values: &Vec<i32>, y_values: &Vec<i32>) -> Vec<Point> {
    x_values.iter()
        .zip(y_values.iter())
        .map(|(x, y)| Point::new(*x, *y))
        .collect()
}

// Find Convex Hull using Jarvis' algorithm
// Source: https://www.geeksforgeeks.org/convex-hull-using-jarvis-algorithm-or-wrapping/
fn convex_hull(points: &Vec<Point>) -> Vec<Point> {
    let n = points.len();

    // Initialize hull points
    let mut hull_points: Vec<Point> = vec![];

    // The first point is the leftmost point with the highest y-coord in the
    // event of a tie
    let l = points.iter()
        .enumerate()
        .map(|(n, point)| (point.x, -point.y, n))
        .min()
        .unwrap()
        .2;

    // Repeat until wrapped around to first hull point
    let mut p = l;
    loop {
        // Store convex hull point
        hull_points.push(points[p]);

        let mut q = (p + 1) % n;
        for j in 0..n {
            // If point j is more counter-clockwise, then update end point (q)
            if orientation(&points[p], &points[j], &points[q]) < 0 {
                q = j;
            }
        }

        p = q;
        if p == l {
            break;
        }
    }

    hull_points
}

// Get orientation of three points
//
// 0 = points are in a line
// > 0 = points are clockwise
// < 0 = points are counter-clockwise
fn orientation(p: &Point, q: &Point, r: &Point) -> i32 {
    (q.y - p.y) * (r.x - q.x) - (q.x - p.x) * (r.y - q.y)
}

fn show_points(points: &Vec<Point>) {
    for point in points {
        println!("{point:?}");
    }
}

fn main() {
    let mut args = args().skip(1);

    // Convert 1st command-line argument to list of integers
    let x_values: Vec<i32> = args
        .next()
        .and_then(|s| parse_int_list(&s).ok())
        .unwrap_or_else(|| usage());

    // Convert 2nd command-line argument to list of integers
    let y_values: Vec<i32> = args
        .next()
        .and_then(|s| parse_int_list(&s).ok())
        .unwrap_or_else(|| usage());

    // Exit if not same number of points or less than 3 points
    let num_x = x_values.len();
    let num_y = y_values.len();
    if num_x != num_y || num_x < 3 || num_y < 3 {
        usage();
    }

    // Combine values into set of points
    let points: Vec<Point> = form_points(&x_values, &y_values);

    // Get convex hull of points and show points
    let hull_points = convex_hull(&points);
    show_points(&hull_points);
}
