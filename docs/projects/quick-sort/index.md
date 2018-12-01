---
title: Quick Sort in Every Language layout: default
date: 2018-11-29
last-modified: 2018-11-29
featured-image:
tags: [quick-sort]
authors:
  - auroq
---

## Description

Quick sort is an algorithm that works by dividing a list into smaller lists.
It recursively partially sorts and divides each sublist into further lists until it
reaches the base case of a list that is either empty or contains only a single element, because
those cases are by definition already sorted. After that it concatenates all of the sublists
together into a single sorted list.

Step by step the process is:

1. Pick an element. This element is called the pivot.
2. Move all elements in the list that are greater than the pivot after the pivot
3. Move all elements that are less than the pivot before the pivot.
4. Recursively repeat steps 1-4 until a list of size 0-1 is found.
5. Concatinate all the sublists into a single sorted list.

### Performance

The performance of sorting algorithms is generally defined in "Big O notation".
If you are not familiar with such notations, please refer to the relevant
article by Rob Bell or the wikipedia entry listed in further readings below.

| | |
|---|---|
| Best case | O(n log n) |
| Average case | O(n log n) |
| Worst case | O(n<sup>2</sup>) |

As the name implies, quicksort is a rather efficient algorithm; however,
its performance can be affected by the pivot that is selected. For example,
always selecting the last element in the list (or sublist) can make the algorithm easy
to write, but on a sorted list that will lead to an efficiency of O(n<sup>2</sup>)
(the worst case).

### Examples

The example below was taken from [Wikipedia's article about Quick sort][1].
The __bolded__ elements are the pivots. In this example, the last element in each list/sublist
was chosen to be the pivot, but that is not necesary. (See the section about performance above.)
Each row shows the comparison of an element to the pivot (steps 2-3).
The arrows convey splitting each list into sublists and then bringing them back together (steps
4-5).


![Quick sort example](https://upload.wikimedia.org/wikipedia/commons/a/af/Quicksort-diagram.svg)


## Requirements

Write a sample program that takes a list of numbers in the format "4, 5, 3, 1, 2".
It should then sort the numbers and output them:

```console
$ ./quick-sort.lang "4, 5, 3, 1, 2"
1, 2, 3, 4, 5
```

The solution should handle duplicate elements

```console
$ ./quick-sort.lang "4, 5, 3, 1, 4, 2"
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

{% include article_list.md collection=site.categories.quick-sort %}

## Further Readings

- [Quick sort on Wikipedia][1]
- [A beginner's guide to Big O notation- Rob Bell][2]
- [Big O notation on Wikipedia][3]

[1]: https://en.wikipedia.org/wiki/Quick_sort
[2]: https://rob-bell.net/2009/06/a-beginners-guide-to-big-o-notation/
[3]: https://en.wikipedia.org/wiki/Big_O_notation
