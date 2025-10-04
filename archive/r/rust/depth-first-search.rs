use std::env::args;
use std::process::exit;
use std::str::FromStr;
use std::collections::{HashMap, HashSet};

fn usage() -> ! {
    println!(
        "Usage: please provide a tree in an adjacency matrix form \
        (\"0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0\") \
        together with a list of vertex values (\"1, 3, 5, 2, 4\") \
        and the integer to find (\"4\")"
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
    id: i32,
    children: HashSet<i32>,
}

impl Node {
    fn new(id: i32) -> Self {
        Self {id: id, children: HashSet::<i32>::new()}
    }

    fn add_child(&mut self, id: i32) {
        self.children.insert(id);
    }
}

#[derive(Debug, Clone)]
struct Tree {
    root_id: i32,
    tree: HashMap<i32, Node>,
}

impl Tree {
    fn new(root_id: i32) -> Self {
        Self {root_id: root_id, tree: HashMap::<i32, Node>::new()}
    }

    fn add_node(&mut self, from_id: i32, node: &Node) {
        self.tree.insert(from_id, node.clone());
    }

    fn get_node(&self, node_id: Option<i32>) -> Option<Node> {
        match node_id {
            None=> None,
            Some(id) => self.tree.get(&id).cloned(),
        }
    }
}

fn create_tree(adjacency_matrix: &Vec<i32>, vertices: &Vec<i32>) -> Tree {
    // Create tree and add nodes
    let mut tree: Tree = Tree::new(vertices[0]);
    let mut nodes: Vec<Node> = vertices.iter()
        .map(|id| Node::new(*id))
        .collect();

    // Add child nodes to each node based on non-zero values of adjacency matrix
    let mut adjacency_iter = adjacency_matrix.iter();
    let num_vertices = vertices.len();
    for row in 0..num_vertices {
        for col in 0..num_vertices {
            if *adjacency_iter.next().unwrap_or_else(|| &0) != 0 {
                nodes[row].add_child(vertices[col]);
            }
        }

        tree.add_node(vertices[row], &nodes[row]);
    }

    tree
}

fn depth_first_search(tree: &Tree, target: i32) -> Option<Node> {
    // Indicate no nodes visited
    let mut visited: HashSet<i32> = HashSet::<i32>::new();

    // Perform depth first recursively starting at root of tree
    depth_first_search_rec(
        tree, tree.get_node(Some(tree.root_id)), target, &mut visited
    )
}

fn depth_first_search_rec(
    tree: &Tree, node: Option<Node>, target: i32, visited: &mut HashSet<i32>
) -> Option<Node> {
    // If invalid node, return it
    if node.is_none() {
        return node;
    }

    // If target found, return it
    let unwrapped_node: Node = node.clone().unwrap();
    if unwrapped_node.id == target {
        return node;
    }

    // Indicate this node is visited
    visited.insert(unwrapped_node.id);

    // Perform depth first search on each unvisited child of this node (if any).
    // Stop when match is found
    let mut found: Option<Node> = None;
    for child_id in unwrapped_node.children {
        if !visited.contains(&child_id) {
            visited.insert(child_id);
            found = depth_first_search_rec(
                tree, tree.get_node(Some(child_id)), target, visited
            );
            if !found.is_none() {
                break;
            }
        }
    }

    found
}

fn main() {
    let mut args = args().skip(1);

    // Convert 1st command-line argument to list of integers
    let adjacency_matrix: Vec<i32> = args
        .next()
        .and_then(|s| parse_int_list(&s).ok())
        .unwrap_or_else(|| usage());

    // Convert 2nd command-line argument to list of integers
    let vertices: Vec<i32> = args
        .next()
        .and_then(|s| parse_int_list(&s).ok())
        .unwrap_or_else(|| usage());


    // Convert 3rd command-line argument to integer
    let target: i32 = args
        .next()
        .and_then(|s| parse_int(&s).ok())
        .unwrap_or_else(|| usage());

    // Create tree
    let tree = create_tree(&adjacency_matrix, &vertices);

    // Run depth first search and indicate if value is found
    match depth_first_search(&tree, target) {
        Some(_) => println!("true"),
        None => println!("false"),
    }
}
