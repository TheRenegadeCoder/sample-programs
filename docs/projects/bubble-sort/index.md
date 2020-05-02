---
title: Bubble Sort in Every Language
layout: default
date: 2018-11-29
last-modified: 2020-05-02
featured-image:
tags: [bubble-sort]
authors:
  - auroq
---

In this article, we'll introduce Bubble Sort, a type of sorting algorithm. 

## Description

Bubble sort is a sorting algorithm that repeatedly cycles through a list of elements
and swaps adjacent elements if they are not in order. It works as follows:

1. Identify the next two adjacent elements in the list (start with the 1st and 2nd, then 2nd and 3rd, 3rd and 4th, and so on)
2. If the elements are not in order swap them.
3. If the end of this list has not been reached, repeat steps 1-3 again
4. If any elements were swapped in the above pass, repeat steps 1-4 again


### Performance

The performance of sorting algorithms is generally defined in "Big O notation".
If you are not familiar with such notations, please refer to the relevant
article by Rob Bell or the wikipedia entry listed in further readings below.

| | |
|---|---|
| Best case | O(n) |
| Average case | O(n<sup>2</sup>) |
| Worst case | O(n<sup>2</sup>) |

Bubble sort is generally not an efficient sorting algorithm; however, it does have one advantage.
When the elements are already sorted, bubble sort will only pass throught the list once; whereas,
most other algorithms will still perform their complete sorting process.


### Example: "4, 5, 3, 1, 2"

In the example below, "pass" refers to one pass through the list (steps 1-4 one time).
Each row in the pass shows a single comparison (steps 1-2 one time).
The elements in __bold__ on each line are the two being compared.
If the row is labeled "swap," a swap will occur after the comparison.

__Pass 1__
- __4__ __5__   3     1     2
-   4   __5__ __3__   1     2   -> swap
-   4     3   __5__ __1__   2   -> swap
-   4     3     1   __5__ __2__ -> swap

__Pass 2__
- __4__ __3__   1     2     5   -> swap
-  3    __4__ __1__   2     5   -> swap
-  3      1   __4__ __2__   5   -> swap
-  3      1     2   __4__ __5__

__Pass 3__
- __3__ __1__   2     4     5   -> swap
-  1    __3__ __2__   4     5   -> swap
-  1      2   __3__ __4__   5
-  1      2     3   __4__ __5__

__Pass 4__
- __1__ __2__   3     4     5
-  1    __2__ __3__   4     5
-  1      2   __3__ __4__   5
-  1      2     3   __4__ __5__

Note that although the elements were sorted at the end of pass 3,
the algorithm needs an additional pass without any swapping in order to know that the elements are sorted.

## Requirements

Write a sample program that takes a list of numbers in the format "4, 5, 3, 1, 2".
It should then sort the numbers and output them:

```console
$ ./bubble-sort.lang "4, 5, 3, 1, 2"
1, 2, 3, 4, 5
```

The solution should handle duplicate elements

```console
$ ./bubble-sort.lang "4, 5, 3, 1, 4, 2"
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
| Invalid Input: Not a List    | 1     | Usage: please provide a list of at least two integers to sort in the format "1, 2, 3, 4, 5" |
| Invalid Input: Wrong Format  | 4 5 3 | Usage: please provide a list of at least two integers to sort in the format "1, 2, 3, 4, 5" |
| Sample Input                 | 4, 5, 3, 1, 2             | 1, 2, 3, 4, 5             |
| Sample Input: With Duplicate | 4, 5, 3, 1, 4, 2          | 1, 2, 3, 4, 4, 5          |
| Sample Input: Already Sorted | 1, 2, 3, 4, 5             | 1, 2, 3, 4, 5             |
| Sample Input: Reverse Sorted | 9, 8, 7, 6, 5, 4, 3, 2, 1 | 1, 2, 3, 4, 5, 6, 7, 8, 9 |

## Articles

{% include article_list.md collection=site.categories.bubble-sort %}

## Further Readings

- [Bubble sort on Wikipedia][1]
- [A beginner's guide to Big O notation- Rob Bell][2]
- [Big O notation on Wikipedia][3]

[1]: https://en.wikipedia.org/wiki/Bubble_sort
[2]: https://rob-bell.net/2009/06/a-beginners-guide-to-big-o-notation/
[3]: https://en.wikipedia.org/wiki/Big_O_notation
