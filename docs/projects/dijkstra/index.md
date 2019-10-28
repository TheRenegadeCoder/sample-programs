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

Below are the detailed steps used in Dijkstra’s algorithm to find the shortest path from a single source vertex to all other vertices in the given graph.
Algorithm
1) Create a set sptSet (shortest path tree set) that keeps track of vertices included in shortest path tree, i.e., whose minimum distance from source is calculated and finalized. Initially, this set is empty.
2) Assign a distance value to all vertices in the input graph. Initialize all distance values as INFINITE. Assign distance value as 0 for the source vertex so that it is picked first.
3) While sptSet doesn’t include all vertices

    a) Pick a vertex u which is not there in sptSet and has minimum distance value.
  
    b) Include u to sptSet.
  
    c) Update distance value of all adjacent vertices of u. To update the distance values, iterate through all adjacent vertices. For every           adjacent vertex v, if sum of distance value of u (from source) and weight of edge u-v, is less than the distance value of v, then update the  distance value of v.

## Example

Dijkstra's algorithm to find the shortest path between a and b. It picks the unvisited vertex with the low distance, calculates the distance through it to each unvisited neighbor, and updates the neighbor's distance if smaller. Mark visited (set to red) when done with neighbors.

![Dijkstra_Animation](https://user-images.githubusercontent.com/35429211/67672949-a2dcfd80-f981-11e9-862a-96bd0ec9ba83.gif)

## Requirements

```console
./dijkstra.lang "4, 3, 2, 1, 3, 1, 3, 1, 3, 4, 5, 2, 3"
```

Here we've chosen to represent the graph as a adjacency list of pairs of integers.

First number is the number of nodes (n).

Second number in the number of edges (m).

Then we take m * 3 number as input.

Then two numbers (Source, Destination).


## Testing

| Description      | Input                                                                       | Output                                                     |
| ---------------- | --------------------------------------------------------------------------- | ---------------------------------------------------------- |
| No Input         |                                                                             | "Usage: please provide a comma-separated list of integers" |
| Empty Input      | ""                                                                          | "Usage: please provide a comma-separated list of integers" |
| Input < 2 | "3"                                                          | "Usage: please provide a comma-separated list of integers" |
| number of nodes < 2 | "1, 1, 1, 2, 3, 1, 2"                                                          | "Usage: please provide a comma-separated list of integers" |
| number of edges < 1 | "1, 0"                                                          | "Usage: please provide a comma-separated list of integers" |
| Input size != 4 + m * 3 | "2, 1, 1, 2, 3, 1"                                                          | "Usage: please provide a comma-separated list of integers" |
| Proper Input     | "2, 1, 1, 2, 3, 1, 2" | 3                                                       |

## Resources

[Dijkstra's algorithm Wikipedia][1]

[Dijkstra’s shortest path algorithm][2]

[1]: https://en.wikipedia.org/wiki/Dijkstra%27s_algorithm
[2]: https://www.geeksforgeeks.org/dijkstras-shortest-path-algorithm-greedy-algo-7

[1]: https://www.youtube.com/watch?v=4ZlRH0eK-qQ
