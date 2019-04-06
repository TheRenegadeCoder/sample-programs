---
title: Fibonacci in Every Language
layout: default
date: 2018-11-01
last-modified: 2018-11-02
featured-image:
tags: [fibonacci]
authors:
---

In this article, we'll tackle the Fibonacci problem, its requirements, and how
to test it.

## Description

In mathematics, the Fibonacci numbers are the numbers in the following integer
sequence, called the Fibonacci sequence, and characterized by the fact that
every number after the first two is the sum of the two preceding ones:

    1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, ...

## Requirements

For this sample program, each solution should leverage dynamic programming to produce this
list up to the nth term. For instance, `./fib 5` on the command line should output

```
1: 1
2: 1
3: 2
4: 3
5: 5
```

In addition, there should be some error handling for situations where the user
doesn't supply any input or the user supplies input that is not a number
(i.e. `./fib` or `./fib hello`, respectively).

## Testing

Some tests for your program are:

| Description | Input | Output |
| :---------- | :---- | :----- |
| No Input                    |      | "Usage please provide the number of fibonacci numbers to output" |
| Empty Input                 | ""   | "Usage please provide the number of fibonacci numbers to output" |
| Invalid Input: not a number | word | "Usage please provide the number of fibonacci numbers to output" |
| Sample Input: 0  | 0  | |
| Sample Input: 1  | 1  | 1: 1 |
| Sample Input: 2  | 2  | 1: 1<br />2: 2 |
| Sample Input: 5  | 5  | 1: 1<br />2: 2<br />3: 3<br />4: 4<br />5: 5 |
| Sample Input: 10 | 10 | 1: 1<br />2: 2<br />3: 3<br />4: 4<br />5: 5<br />6: 6<br />7: 7<br />8: 8<br />9: 9<br />10: 10 |

## Articles

{% include article_list.md collection=site.categories.fibonacci %}

## Further Readings

- Fill as needed

[1]: #requirements
