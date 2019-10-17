---
title: Linear Search in Every Language
layout: default
date: 2019-10-17
last-modified: 2019-10-17
featured-image:
tags: [linear-search]
authors:
  - frankhart2017
---

This article introduces Linear Search which is the simplest search algorithm.

## Description

Linear search is quite intuitive, it is basically searching an element in an array by traversing the array from the beginning to the end and comparing each item in the array with the key. If a particular array entry matches with the key the position is recorded and the loop is stopped. The algorithm for this is:

1. Define a flag (set it's value to 0) for checking if key is present in array or notation.
2. Iterate through every element in array.
3. In each iteration compare the key and the current element.
4. If they match set the flag to 1, position to the current iteration and break from the loop.
5. If entire loop is traversed and the element is not found the value of flag will be 0 and user can notified that key is not in array.


### Performance

The performance of searching algorithms is generally defined in "Big O notation".
If you are not familiar with such notations, please refer to the relevant
article by Rob Bell or the wikipedia entry listed in further readings below.

| | |
|---|---|
| Best case | O(1) |
| Average case | O(n) |
| Worst case | O(n) |

Linear search is not efficient for large arrays, but for relatively smaller arrays it works fine.

### Example: key=3, array=[1, 2, 3, 4, 5]

<b>Iteration 1</b>
<br>array[i] = array[0] = 1
<br>key = 3
<br>key != array[i]

<b>Iteration 2</b>
<br>array[i] = array[i] = 2
<br>key = 3
<br>key != array[i]

<b>Iteration 3</b>
<br>array[i] = array[2] = 3
<br>key = 3
<br>key = array[i]
<br>break
<br>flag = 1
<br>pos = 2

## Requirements

Write a sample program that takes a key in the format 3 and a list of numbers in the format "1, 2, 3, 4, 5".
#### C++ Program:

```console
$ cd archives/c/c-plus-plus/
$ g++ -o linear-search linear-search.cpp
$ ./linear-search 3 "1, 2, 3, 4, 5"
3 found at position 2.
```

#### Python Program:

```console
$ cd archives/p/python/
$ python linear-search.py 6 "1, 2, 3, 4, 5"
6 not found in the array .
```

In addition, there should be some error handling for situations where the user
doesn't supply correct input.

## Articles

{% include article_list.md collection=site.categories.linear-search %}

## Further Readings

- [Linear search on Wikipedia][1]
- [A beginner's guide to Big O notation- Rob Bell][2]
- [Big O notation on Wikipedia][3]

[1]: https://en.wikipedia.org/wiki/Linear_search
[2]: https://rob-bell.net/2009/06/a-beginners-guide-to-big-o-notation/
[3]: https://en.wikipedia.org/wiki/Big_O_notation
