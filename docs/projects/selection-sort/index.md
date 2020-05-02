---
title: Selection Sort in Every Language 
layout: default
date: 2018-11-29
last-modified: 2020-05-02
featured-image:
tags: [selection-sort]
authors:
  - auroq
---

In this article, we'll tackle Selection Sort, an inefficient sorting algorithm.

## Description

Selection sort is an algorithm that operates on two lists, one of sorted elements and one of unsorted.
With each pass, the algorithm finds the smallest item in the unsorted list and moves it
to the front of the sorted list. At the beginning the sorted list is empty, and the algorithm completes
when the unsorted list is empty (meaning that all elements have been moved to the sorted list).

There is also a variant that uses a single list and moves the elements in place. In this variant,
the sorted elements are just placed at the front of the list rather than in a separate list, and
the algorithm starts each pass with the index of the first unsorted element in the list.

### Performance

The performance of sorting algorithms is generally defined in "Big O notation".
If you are not familiar with such notations, please refer to the relevant
article by Rob Bell or the wikipedia entry listed in further readings below.

| | |
|---|---|
| Best case | O(n<sup>2</sup>) |
| Average case | O(n<sup>2</sup>) |
| Worst case | O(n<sup>2</sup>) |

Selection sort always performs at O(n<sup>2</sup>). This is because the algorithm's
loops do not depend on the values of the items in the list. That means that even if
the list is already sorted, the full sorting process will still be performed.

### Examples: Two lists

In the examples below, each row is a single pass through all elements in the unsorted list.
The element in __bold__ is the one that will be moved to the sorted list after the pass.

#### "4, 5, 3, 1, 2"

| Sorted List | Unsorted List                 |
|-------------|-------------------------------|
|             |   4     5     3   __1__   2   |
| 1           |   4     5     3   __2__       |
| 1 2         |   4     5   __3__             |
| 1 2 3       | __4__   5                     |
| 1 2 3 4     | __5__                         |
| 1 2 3 4 5   |                               |

#### "3, 5, 4, 1, 2"

| Sorted List | Unsorted List                 |
|-------------|-------------------------------|
|             |   3     5     4   __1__   2   |
| 1           |   3     5     4   __2__       |
| 1 2         | __3__   5     4               |
| 1 2 3       |   5   __4__                   |
| 1 2 3 4     | __5__                         |
| 1 2 3 4 5   |                               |


### Examples: Single list

In the examples below, each row is a single pass through all elements in the unsorted list.
The element in __bold__ is the one that will be moved to the end of the sorted section after the pass.

#### "4, 5, 3, 1, 2"

-   4     5     3   __1__   2   
-   1     4     5     3   __2__ 
-   1     2     4     5   __3__ 
-   1     2     3   __4__   5   
-   1     2     3     4   __5__ 
-   1     2     3     4     5    

#### "3, 5, 4, 1, 2"

-   3     5     4   __1__   2   
-   1     3     5     4   __2__ 
-   1     2   __3__   5     4   
-   1     2     3     5   __4__ 
-   1     2     3     4   __5__ 
-   1     2     3     4     5    

## Requirements

Write a sample program that takes a list of numbers in the format "4, 5, 3, 1, 2".
It should then sort the numbers and output them:

```console
$ ./selection-sort.lang "4, 5, 3, 1, 2"
1, 2, 3, 4, 5
```

The solution should handle duplicate elements

```console
$ ./selection-sort.lang "4, 5, 3, 1, 4, 2"
1, 2, 3, 4, 4, 5
```

In addition, there should be some error handling for situations where the user
doesn't supply correct input.

## Testing

The following table contains various test cases that you can use to
verify the correctness of your solution:

| Description                  | Input | Output |
|------------------------------|-------|--------|
| No Input                     |       | Usage: please provide a list of at least two integers to sort in the format "1, 2, 3, 4, 5" |
| Empty Input                  | ""    | Usage: please provide a list of at least two integers to sort in the format "1, 2, 3, 4, 5" |
| Invalid Input: Not a list    | 1     | Usage: please provide a list of at least two integers to sort in the format "1, 2, 3, 4, 5" |
| Invalid Input: Wrong Format  | 4 5 3 | Usage: please provide a list of at least two integers to sort in the format "1, 2, 3, 4, 5" |
| Sample Input                 | 4, 5, 3, 1, 2             | 1, 2, 3, 4, 5             |
| Sample Input: With Duplicate | 4, 5, 3, 1, 4, 2          | 1, 2, 3, 4, 4, 5          |
| Sample Input: Already Sorted | 1, 2, 3, 4, 5             | 1, 2, 3, 4, 5             |
| Sample Input: Reverse Sorted | 9, 8, 7, 6, 5, 4, 3, 2, 1 | 1, 2, 3, 4, 5, 6, 7, 8, 9 |

## Articles

{% include article_list.md collection=site.categories.selection-sort %}

## Further Reading

- [Selection sort on Wikipedia][1]
- [A beginner's guide to Big O notation- Rob Bell][2]
- [Big O notation on Wikipedia][3]

[1]: https://en.wikipedia.org/wiki/Selection_sort
[2]: https://rob-bell.net/2009/06/a-beginners-guide-to-big-o-notation/
[3]: https://en.wikipedia.org/wiki/Big_O_notation
