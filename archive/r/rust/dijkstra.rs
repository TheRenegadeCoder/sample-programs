use std::env::args;
use std::process::exit;
use std::str::FromStr;
use std::collections::{HashMap, HashSet};

fn usage() -> ! {
    println!(
        "Usage: please provide three inputs: a serialized matrix, \
        a source node and a destination node"
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

#[derive(Debug, Clone)]
struct Node {
    index: usize,
    children: HashMap<usize, u32>,
}

impl Node {
    fn new(index: usize) -> Self {
        Self {index: index, children: HashMap::<usize, u32>::new()}
    }

    fn add_child(&mut self, index: usize, weight: u32) {
        self.children.insert(index, weight);
    }
}

type Tree = Vec<Node>;

fn create_tree(weights: &Vec<u32>, num_vertices: usize) -> Tree {
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
    weights: &Vec<u32>, num_vertices: usize, src: usize, dest: usize
) -> bool {
    // Verify the following:
    // - Number of weights is a square
    // - Any non-zero weights
    // - Source and destination are in range
    weights.len() == num_vertices * num_vertices
    && *weights.iter().max().unwrap() > 0
    && src < num_vertices
    && dest < num_vertices
}

#[derive(Debug, Clone)]
struct DijkstraItem {
    prev: usize,
    dist: u32,
}

impl DijkstraItem {
    fn new(prev: usize, dist: u32) -> DijkstraItem {
        DijkstraItem {prev: prev, dist: dist}
    }
}

// Source: https://en.wikipedia.org/wiki/Dijkstra%27s_algorithm#Pseudocode
fn dijkstra(tree: &Tree, src: usize) -> Vec<DijkstraItem> {
    // Initialize distances to infinite and previous vertices to undefined
    // Set source vertex distance to 0
    // Indicate all nodes unvisited
    let num_vertices = tree.len();
    let mut results: Vec<DijkstraItem> = vec![DijkstraItem::new(0, u32::MAX); num_vertices];
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
        for (&v, &weight) in tree[u].children.iter() {
            if !visited.contains(&v) {
                // Get trial distance
                let alt = results[u].dist + weight;

                // If trial distance is smaller than distance v, update distance to v and
                if alt < results[v].dist {
                    results[v].dist = alt;
                    results[v].prev = u;
                }
            }
        }
    }

    results
}

fn main() {
    let mut args = args().skip(1);

    // Convert 1st command-line argument to list of integers
    let weights: Vec<u32> = args
        .next()
        .and_then(|s| parse_int_list(&s).ok())
        .unwrap_or_else(|| usage());

    // Convert 2nd command-line argument to integer
    let src: usize = args
        .next()
        .and_then(|s| parse_int(&s).ok())
        .unwrap_or_else(|| usage());

    // Convert 3rd command-line argument to integer
    let dest: usize = args
        .next()
        .and_then(|s| parse_int(&s).ok())
        .unwrap_or_else(|| usage());

    // Exit if invalid inputs
    let num_weights = weights.len();
    let num_vertices = (num_weights as f32).sqrt().round() as usize;
    if !validate_inputs(&weights, num_vertices, src, dest) {
        usage();
    }

    // Create tree
    let tree = create_tree(&weights, num_vertices);

    // Run Dijkstra's algorithm on graph and show distance to destination
    let results = dijkstra(&tree, src);
    println!("{}", results[dest].dist);
}
