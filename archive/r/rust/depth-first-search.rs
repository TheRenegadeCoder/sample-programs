use std::env::args;
use std::process::exit;
use std::num::ParseIntError;

fn usage() -> ! {
    println!(
        "Usage: please provide a tree in an adjacency matrix form \
        (\"0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0\") \
        together with a list of vertex values (\"1, 3, 5, 2, 4\") \
        and the integer to find (\"4\")"
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
    id: i32,
    children_indices: Vec<usize>,
}

impl Node {
    fn new(id: i32) -> Node {
        Node {id: id, children_indices: vec![]}
    }

    fn add_child(&mut self, child_index: usize) {
        self.children_indices.push(child_index);
    }
}

fn create_tree(adjacency_matrix: &Vec<i32>, vertices: &Vec<i32>) -> Vec<Node> {
    // Create nodes
    let mut nodes: Vec<Node> = vertices.iter()
        .map(|id| Node::new(*id))
        .collect();

    // Add child nodes to each node based on non-zero values of adjacency matrix
    let mut adjacency_iter = adjacency_matrix.iter();
    let num_vertices = vertices.len();
    for row in 0..num_vertices {
        for col in 0..num_vertices {
            if *adjacency_iter.next().unwrap_or_else(|| &0) != 0 {
                nodes[row].add_child(col)
            }
        }
    }

    nodes
}

fn depth_first_search(tree: &Vec<Node>, target: i32) -> Option<usize> {
    // Indicate no nodes visited
    let mut visited: Vec<bool> = (0..tree.len())
        .map(|_| false)
        .collect();

    // Perform depth first recursively starting at root of tree
    depth_first_search_rec(tree, Some(0), target, &mut visited)
}

fn depth_first_search_rec(
    tree: &Vec<Node>, node_index: Option<usize>, target: i32, visited: &mut Vec<bool>
) -> Option<usize> {
    // If invalid node index, return it
    if node_index.is_none() {
        return node_index;
    }

    // If target found, return it
    let unwrapped_node_index: usize = node_index.unwrap();
    let node: Node = tree[unwrapped_node_index].clone();
    if node.id == target {
        return node_index
    }

    // Indicate this node is visited
    visited[unwrapped_node_index] = true;

    // Perform depth first search on each unvisited child of this node (if any).
    // Stop when match is found
    let mut found: Option<usize> = None;
    for child_index in node.children_indices {
        if !visited[child_index] {
            visited[child_index] = true;
            found = depth_first_search_rec(tree, Some(child_index), target, visited);
            if !found.is_none() {
                break;
            }
        }
    }

    found
}

fn main() {
    // Convert 1st command-line argument to list of integers
    let adjacency_matrix: Vec<i32> = parse_int_list(
        args().nth(1)
        .unwrap_or_else(|| usage())
    ).unwrap_or_else(|| usage());

    // Convert 2nd command-line argument to list of integers
    let vertices: Vec<i32> = parse_int_list(
        args().nth(2)
        .unwrap_or_else(|| usage())
    ).unwrap_or_else(|| usage());

    // Convert 3rd command-line argument to integer
    let target: i32 = parse_int(
        args().nth(3)
        .unwrap_or_else(|| usage())
    ).unwrap_or_else(|_| usage());

    // Create tree
    let tree = &create_tree(&adjacency_matrix, &vertices);

    // Run depth first search and indicate if value is found
    match depth_first_search(&tree, target) {
        Some(_) => println!("true"),
        None => println!("false"),
    }
}
