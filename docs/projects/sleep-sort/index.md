---
title: Sleep Sort in Every Language
layout: default
date: 2019-10-08
last-modified: 2020-05-02
featured-image:
tags: [sleep-sort]
authors:
  - agilob
---

In this article, we'll introduce Sleep Sort, a wired type of sorting algorithm. 

## Description

Sleep sort is a sorting algorithm that for each input numeric variable it starts a thread (or thread like process) that automatically goes to sleep for given number of time units, eg. seconds. When a thread complets, it returns the number. When all threads complete, a sorted array of numbers is returned.


### Performance

Time complexity of this algorithm strictly depends on value of the highest number, therefore it's always O(n), space complexity is dependent on numbers of threads started - O(n) where n is number of inputs.


## Requirements

Write a sample program that takes a list of numbers in the format "4, 5, 3, 1, 2".
It should then sort the numbers and output them:

```console
$ ./sleep-sort.lang "4 5 3 1 2"
1, 2, 3, 4, 5
```

## Testing

The following table contains various test cases that you can use to
verify the correctness of your solution:

| Description                  | Input | Output |
|------------------------------|-------|--------|
| Sample Input                 | 4, 5, 3, 1, 2             | 1, 2, 3, 4, 5             |
| Sample Input: With Duplicate | 4, 5, 3, 1, 4, 2          | 1, 2, 3, 4, 4, 5          |
| Sample Input: Already Sorted | 1, 2, 3, 4, 5             | 1, 2, 3, 4, 5             |
| Sample Input: Reverse Sorted | 9, 8, 7, 6, 5, 4, 3, 2, 1 | 1, 2, 3, 4, 5, 6, 7, 8, 9 |


## Further Readings

- [Sleep sort on Quora][1]

[1]: https://www.quora.com/What-is-sleep-sort
