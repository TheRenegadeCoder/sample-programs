use std::env::args;
use std::process::exit;
use std::num::ParseIntError;
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
    children: Vec<i32>,
}

impl Node {
    fn new(id: i32) -> Node {
        Node {id: id, children: Vec::<i32>::new()}
    }

    fn add_child(&mut self, child_id: i32) {
        self.children.push(child_id)
    }
}

#[derive(Debug, Clone)]
struct Graph {
    root_id: i32,
    tree: HashMap<i32, Node>,
}

impl Graph {
    fn new(root_id: i32) -> Graph {
        Graph {root_id: root_id, tree: HashMap::<i32, Node>::new()}
    }

    fn get_root(self) -> Option<Node> {
        self.tree.get(&self.root_id).cloned()
    }

    fn find(self, id: i32) -> Option<Node> {
        self.tree.get(&id).cloned()
    }

    fn add_vertex(&mut self, vertex_id: i32) {
        self.tree.insert(vertex_id, Node::new(vertex_id));
    }

    fn add_edge(&mut self, from_id: i32, to_id: i32) {
        self.tree.get_mut(&from_id)
            .unwrap()
            .add_child(to_id);
    }
}

fn create_graph(adjacency_matrix: &Vec<i32>, vertices: &Vec<i32>) -> Graph {
    // Add child nodes to each node based on non-zero values of adjacency matrix
    let mut graph = Graph::new(vertices[0]);
    let mut adjacency_iter = adjacency_matrix.iter();
    for row_vertex in vertices {
        graph.add_vertex(*row_vertex);
        for col_vertex in vertices {
            if *adjacency_iter.next().unwrap_or_else(|| &0) != 0 {
                graph.add_edge(*row_vertex, *col_vertex);
            }
        }
    }

    graph
}

fn depth_first_search(graph: &Graph, target: i32) -> Option<Node> {
    // Indicate no nodes visited
    let mut visited: HashSet<i32> = HashSet::<i32>::new();

    // Perform depth first recursively starting at root of tree
    depth_first_search_rec(graph, graph.clone().get_root(), target, &mut visited)
}

fn depth_first_search_rec(
    graph: &Graph, node: Option<Node>, target: i32, visited: &mut HashSet<i32>
) -> Option<Node> {
    // If invalid node, return it
    if node.is_none() {
        return node
    }

    // If target found, return it
    let unwrapped_node: Node = node.clone().unwrap();
    if unwrapped_node.id == target {
        return node
    }

    // Indicate this node is visited
    visited.insert(unwrapped_node.id);

    // Perform depth first search on each unvisited child of this node (if any).
    // Stop when match is found
    let mut found: Option<Node> = None;
    for child_id in unwrapped_node.children {
        if !visited.contains(&child_id) {
            let child: Option<Node> = graph.clone().find(child_id);
            visited.insert(child_id);
            found = depth_first_search_rec(graph, child, target, visited);
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

    // Create graph
    let graph = &create_graph(&adjacency_matrix, &vertices);

    // Run depth first search and indicate if value is found
    match depth_first_search(&graph, target) {
        Some(_) => println!("true"),
        None => println!("false"),
    }
}
