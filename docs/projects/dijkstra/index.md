---
title: Dijkstra in Every Language
layout: default
date: 2019-10-28
last-modified: 2019-10-28
featured-image: 
authors:
  - fuboki10
---

Dijkstra's algorithm (or Dijkstra's Shortest Path First algorithm, SPF algorithm) is an algorithm for finding the shortest paths between nodes in a graph, which may represent, for example, road networks. It was conceived by computer scientist Edsger W. Dijkstra in 1956 and published three years later.

Dijkstra’s algorithm doesn’t work for graphs with negative weight edges.

Below are the detailed steps used in Dijkstra’s algorithm to find the shortest path from a single source vertex to all other vertices in the given graph.
Algorithm
1) Create a set sptSet (shortest path tree set) that keeps track of vertices included in shortest path tree, i.e., whose minimum distance from source is calculated and finalized. Initially, this set is empty.
2) Assign a distance value to all vertices in the input graph. Initialize all distance values as INFINITE. Assign distance value as 0 for the source vertex so that it is picked first.
3) While sptSet doesn’t include all vertices

    a) Pick a vertex u which is not there in sptSet and has minimum distance value.
  
    b) Include u to sptSet.
  
    c) Update distance value of all adjacent vertices of u. To update the distance values, iterate through all adjacent vertices. For every           adjacent vertex v, if sum of distance value of u (from source) and weight of edge u-v, is less than the distance value of v, then update the  distance value of v.
    
Time Complexity is O(V^2).

Memory Complexity is O(V^2).

## Example

Dijkstra's algorithm to find the shortest path between a and b. It picks the unvisited vertex with the low distance, calculates the distance through it to each unvisited neighbor, and updates the neighbor's distance if smaller. Mark visited (set to red) when done with neighbors.

![Dijkstra_Animation](https://user-images.githubusercontent.com/35429211/67672949-a2dcfd80-f981-11e9-862a-96bd0ec9ba83.gif)

## Requirements

```console
./dijkstra.lang "0, 2, 0, 6, 0, 2, 0, 3, 8, 5, 0, 3, 0, 0, 7, 6, 8, 0, 0, 9, 0, 5, 7, 9, 0" "0" "1"
```

Here we've chosen to represent the matrix as a serialized list of integers. Since
the input string represents a square matrix, we should be able to take the
square root of the length to determine where the rows are in the string. In this
case, we have 25 values, so we must have 5 nodes.
If we reformat the input string as a matrix, we'll notice that the values in the
matrix represent the edge weight between each node. For example, we
could reformat our example to look something like the following:

| Mapping | 0   | 1   | 2   | 3   | 4   |
| ------- | --- | --- | --- | --- | --- |
| 0       | 0   | 2   | 0   | 6   | 0   |
| 1       | 2   | 0   | 3   | 8   | 5   |
| 2       | 0   | 3   | 0   | 0   | 7   |
| 3       | 6   | 8   | 0   | 0   | 9   |
| 4       | 0   | 5   | 7   | 9   | 0   |

Then we take the Source and the Destination.

The Output will be the Cost of the Shortest Path from Source to Destination.  
  
## Testing

| Description      | Matrix   | Source      | Destination | Output                                          |
| ---------------- | -------- | ------------| ----------- | ----------------------------------------------- |
| No Input         |          |             |             | "Usage: please provide a comma-separated list of integers" |
| Empty Input      | ""       |      ""       |       ""     |  "Usage: please provide a comma-separated list of integers" |
| Non-Square Input | "1, 0, 3, 0, 5, 1" |      "1"    |  "2"  | "Usage: please provide a comma-separated list of integers" |
| No Destination | "0, 2, 0, 6, 0, 2, 0, 3, 8, 5, 0, 3, 0, 0, 7, 6, 8, 0, 0, 9, 0, 5, 7, 9, 0" | "0" | "" | "Usage: please provide a destination" |
| No Source and Destination  | "0, 2, 0, 6, 0, 2, 0, 3, 8, 5, 0, 3, 0, 0, 7, 6, 8, 0, 0, 9, 0, 5, 7, 9, 0" | "" | "" | "Usage: please provide source and destination" |
| The Source or The Destination < 0 | "0, 2, 0, 6, 0, 2, 0, 3, 8, 5, 0, 3, 0, 0, 7, 6, 8, 0, 0, 9, 0, 5, 7, 9, 0" | "-1" | "2" | "Usage: please provide positive node number" |
| The Source or The Destination < 0 | "0, 2, 0, 6, 0, 2, 0, 3, 8, 5, 0, 3, 0, 0, 7, 6, 8, 0, 0, 9, 0, 5, 7, 9, 0" | "-1" | "2" | "Usage: please provide positive node number" |
| Weight < 0                 | "0, 2, 0, -6, 0, 2, 0, 3, 8, 5, 0, 3, 0, 0, 7, -6, 8, 0, 0, 9, 0, 5, 7, 9, 0" | "1" | "2" | "Usage: please provide positive weights" | 
| The Source or The Destination > SquareRootOfMatrix - 1 | "0, 2, 0, 6, 0, 2, 0, 3, 8, 5, 0, 3, 0, 0, 7, 6, 8, 0, 0, 9, 0, 5, 7, 9, 0" | "1" | "10" | "Usage: please provide a node number in the Graph" |
| No way                     | "0, 0, 0, 0" | "0" | "1"   |  "There is no way between {Source} and {Destination}"|
| Proper Input               | "0, 2, 0, 6, 0, 2, 0, 3, 8, 5, 0, 3, 0, 0, 7, 6, 8, 0, 0, 9, 0, 5, 7, 9, 0" | "0" | "1" | 2 |

## Further Reading

- [Dijkstra's algorithm Wikipedia][1]
- [Dijkstra’s shortest path algorithm][2]

[1]: https://en.wikipedia.org/wiki/Dijkstra%27s_algorithm
[2]: https://www.geeksforgeeks.org/dijkstras-shortest-path-algorithm-greedy-algo-7
