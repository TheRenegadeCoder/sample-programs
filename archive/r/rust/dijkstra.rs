use std::env::args;
use std::process::exit;
use std::num::ParseIntError;
use std::collections::{HashMap, HashSet};

fn usage() -> ! {
    println!(
        "Usage: please provide three inputs: a serialized matrix, \
        a source node and a destination node"
    );
    exit(0);
}

fn parse_int(s: String) -> Result<i32, ParseIntError> {
    s.trim().parse::<i32>()
}

fn parse_int_list(s_list: String) -> Option<Vec<i32>> {
    let results: Vec<Result<i32, ParseIntError>> = s_list.split(",")
        .map(|s| parse_int(s.to_string()))
        .collect();
    match results.iter().any(|s| s.is_err()) {
        true => None,
        false => Some(
            results.iter()
            .map(|result| result.clone().unwrap())
            .collect()
        )
    }
}

#[derive(Debug, Clone)]
struct Node {
    index: usize,
    children: HashMap<usize, i32>,
}

impl Node {
    fn new(index: usize) -> Node {
        Node {index: index, children: HashMap::<usize, i32>::new()}
    }

    fn add_child(&mut self, index: usize, weight: i32) {
        self.children.insert(index, weight);
    }
}

type Tree = Vec<Node>;

fn create_tree(weights: &Vec<i32>, num_vertices: usize) -> Tree {
    // Create nodes
    let mut nodes: Vec<Node> = (0..num_vertices)
        .map(|index| Node::new(index))
        .collect();

    // Add child nodes to each node based on non-zero values of adjacency matrix
    let mut index = 0;
    for row in 0..num_vertices {
        for col in 0..num_vertices {
            let weight = weights[index];
            index += 1;
            if weight > 0 {
                nodes[row].add_child(col, weight);
            }
        }
    }

    nodes
}

fn validate_inputs(
    weights: &Vec<i32>, num_vertices: usize, src: i32, dest: i32
) -> bool {
    // Verify the following:
    // - Number of weights is a square
    // - Weights greater than equal to zero
    // - Any non-zero weights
    // - Source and destination are in range
    let num_vertices_i32: i32 = num_vertices as i32;
    (
        weights.len() == num_vertices * num_vertices
        && *weights.iter().min().unwrap() >= 0
        && *weights.iter().max().unwrap() > 0
        && src >= 0 && src < num_vertices_i32
        && dest >= 0 && dest < num_vertices_i32
    )
}

#[derive(Debug, Clone)]
struct DijkstraItem {
    prev: usize,
    dist: i32,
}

impl DijkstraItem {
    fn new(prev: usize, dist: i32) -> DijkstraItem {
        DijkstraItem {prev: prev, dist: dist}
    }
}

// Source: https://en.wikipedia.org/wiki/Dijkstra%27s_algorithm#Pseudocode
fn dijkstra(tree: &Tree, src: i32) -> Vec<DijkstraItem> {
    let src: usize = src as usize;

    // Initialize distances to infinite and previous vertices to undefined
    // Set source vertex distance to 0
    // Indicate all nodes unvisited
    let num_vertices = tree.len();
    let mut results: Vec<DijkstraItem> = vec![DijkstraItem::new(0, i32::MAX); num_vertices];
    results[src].dist = 0;
    let mut visited: HashSet<usize> = HashSet::<usize>::new();

    // While any unvisited nodes
    while visited.len() < num_vertices {
        // Pick a vertex u with minimum distance from unvisited nodes
        let u: usize = (0..num_vertices)
            .filter(|index| !visited.contains(index))
            .map(|index| (results[index].dist, index))
            .min()
            .unwrap()
            .1;

        // Indicate vertex u visited
        visited.insert(u);

        // For each unvisited neighbor v of vertex u
        for (v, weight) in tree[u].children.iter() {
            if !visited.contains(v) {
                // Get trial distance
                let alt = results[u].dist + *weight;

                // If trial distance is smaller than distance v, update distance to v and
                if alt < results[*v].dist {
                    results[*v].dist = alt;
                    results[*v].prev = u;
                }
            }
        }
    }

    results
}

fn main() {
    // Convert 1st command-line argument to list of integers
    let weights: Vec<i32> = parse_int_list(
        args().nth(1)
        .unwrap_or_else(|| usage())
    ).unwrap_or_else(|| usage());

    // Convert 2nd command-line argument to integer
    let src: i32 = parse_int(
        args().nth(2).unwrap_or_else(|| usage())
    ).unwrap_or_else(|_| usage());

    // Convert 3rd command-line argument to integer
    let dest: i32 = parse_int(
        args().nth(3).unwrap_or_else(|| usage())
    ).unwrap_or_else(|_| usage());

    // Exit if invalid inputs
    let num_weights = weights.len();
    let num_vertices = (num_weights as f32).sqrt().round() as usize;
    if !validate_inputs(&weights, num_vertices, src, dest) {
        usage();
    }

    // Create tree
    let tree = &create_tree(&weights, num_vertices);

    // Run Dijkstra's algorithm on graph and show distance to destination
    let results = &dijkstra(&tree, src);
    println!("{}", results[dest as usize].dist);
}
