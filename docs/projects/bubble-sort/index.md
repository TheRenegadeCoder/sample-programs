---
title: Bubble Sort in Every Language
layout: default
date: 2018-11-29
last-modified: 2018-11-29
featured-image:
tags: [bubble-sort]
authors:
  - auroq
---

Bubble sort is a sorting algorithm that repeatedly cycles through a list of elements
and swaps adjacent elements if they are not in order. It works as follows:

1. Identify the next two adjacent elements in the list (start with the 1st and 2nd, then 2nd and 3rd, 3rd and 4th, and so on)
2. If the elements are not in order swap them.
3. If the end of this list has not been reached, repeat steps 1-3 again
4. If any elements were swapped in the above pass, repeat steps 1-4 again

In the example below, "pass" refers to one pass through the list (steps 1-4 one time).
Each row in the pass shows a single comparison (steps 1-2 one time).
The elements in _italics_ on each line are the two being compared.
If the row is labeled "swap," a swap will occur after the comparison.

###Sorting "4 5 3 1 2"

__Pass 1__
- _4_ _5_  3   1   2
-  4  _5_ _3_  1   2 -> swap
-  4   3  _5_ _1_  2 -> swap
-  4   3   1  _5_ _2_-> swap

__Pass 2__
- _4_ _3_  1   2   5 -> swap
-  3  _4_ _1_  2   5 -> swap
-  3   1  _4_ _2_  5 -> swap
-  3   1   2  _4_ _5_

__Pass 3__
- _3_ _1_  2   4   5 -> swap
-  1  _3_ _2_  4   5 -> swap
-  1   2  _3_ _4_  5
-  1   2   3  _4_ _5_

__Pass 4__
- _1_ _2_  3   4   5
-  1  _2_ _3_  4   5
-  1   2  _3_ _4_  5
-  1   2   3  _4_ _5_

Note that although the elements were sorted at the end of pass 3,
the algorithm needs an additional path without any swapping in order to know that the elements are sorted.

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

| Description  | Input | Output |
|--------------|-------|--------|
| No Input     | | "Usage: please provide a list of at least two integers to sort in the format "1, 2, 3, 4, 5" |
| Empty Input  | "" | "Usage: please provide a list of at least two integers to sort in the format "1, 2, 3, 4, 5" |
| Invalid Input  | 1 | "Usage: please provide a list of at least two integers to sort in the format "1, 2, 3, 4, 5" |
| Invalid Input  | 4 5 3 | "Usage: please provide a list of at least two integers to sort in the format "1, 2, 3, 4, 5" |
| Sample Input | 4, 5, 3, 1, 2 | 1, 2, 3, 4, 5 |
| Sample Input | 4, 5, 3, 1, 4, 2 | 1, 2, 3, 4, 4, 5 |
| Sample Input | 1, 2, 3, 4, 5 | 1, 2, 3, 4, 5 |
| Sample Input | 13, 4 | 13, 4 |

## Articles

{% include article_list.md collection=site.categories.bubble-sort %}

## Further Readings

- [Bubble sort on Wikipedia][1]

[1]: https://en.wikipedia.org/wiki/Bubble_sort
