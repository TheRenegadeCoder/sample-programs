use std::env::args;
use std::process::exit;
use std::str::FromStr;
use std::collections::{HashMap, HashSet};

fn usage() -> ! {
    println!("Usage: please provide a comma-separated list of integers");
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

#[derive(Debug)]
struct MstResult {
    src_index: usize,
    dest_index: usize,
    weight: i32,
}

impl MstResult {
    fn new(src_index: usize, dest_index: usize, weight: i32) -> MstResult {
        MstResult {src_index: src_index, dest_index: dest_index, weight: weight}
    }
}

// Prim's Minimum Spanning Tree (MST) Algorithm based on C implementation of
// https://www.geeksforgeeks.org/prims-minimum-spanning-tree-mst-greedy-algo-5/
fn prim_mst(tree: &Tree) -> Vec<MstResult> {
    let num_vertices = tree.len();

    // Array to store constructed MST. Indicate no parents yet
    let mut parents = vec![0; num_vertices];

    // Key values used to pick minimum weight edge. Initialize to infinity
    let mut keys = vec![i32::MAX; num_vertices];

    // Indicate nothing in MST yet
    let mut mst_set = HashSet::<usize>::new();

    // Include first vertex in MST
    keys[0] = 0;

    // The MST will include all vertices
    while mst_set.len() < num_vertices {
        // Pick index of the minimum key value not already in MST
        let u: usize = (0..num_vertices)
            .filter(|index| !mst_set.contains(index))
            .map(|index| (keys[index], index))
            .min()
            .unwrap()
            .1;

        // Add picked vertex to MST
        mst_set.insert(u);

        // Update key values and parent indices of picked adjacent
        // vertices. Only consider vertices not yet in MST
        for (v, weight) in tree[u].children.iter() {
            if !mst_set.contains(v) && *weight < keys[*v] {
                parents[*v] = u;
                keys[*v] = *weight;
            }
        }
    }

    // Construct MST information to return, skipping over root
    (1..num_vertices)
        .map(|v| MstResult::new(parents[v], v, keys[v]))
        .collect()
}

fn get_total_mst_weight(mst: &Vec<MstResult>) -> i32 {
    mst.iter()
        .map(|mst_item| mst_item.weight)
        .sum()
}

fn main() {
    let mut args = args().skip(1);

    // Convert 1st command-line argument to list of integers
    let weights: Vec<i32> = args
        .next()
        .and_then(|s| parse_int_list(&s).ok())
        .unwrap_or_else(|| usage());

    // Exit if number of weights is not a square
    let num_weights = weights.len();
    let num_vertices = (num_weights as f32).sqrt().round() as usize;
    if num_weights != num_vertices * num_vertices
    {
        usage();
    }

    // Create tree
    let tree = create_tree(&weights, num_vertices);

    // Get MST using Prim's algorithm
    let mst = prim_mst(&tree);

    // Calculate total weight of MST and display
    println!("{}", get_total_mst_weight(&mst));
}
