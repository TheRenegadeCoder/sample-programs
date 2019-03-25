---
title: Factorial in Every Language
layout: default
date: 2018-11-01
last-modified: 2018-11-02
featured-image:
tags: [factorial]
authors:
---

The factorial of an integer `n` is defined as:

`n! = 1 x 2 x 3 x 4 x ... x n`

With the special case `0! = 1`.

## Requirements

You must write an executable program that accepts an integer `n` on standard
input via the command line, and outputs `n!` to standard output.

Note that the factorial function grows very quickly. For example, `4! = 24`
but `8! = 40320`. Therefore, you should impose a limit on the input, so that
the largest factorial still fits into your language's largest supported datatype.

Also note that the factorial is not defined for negative integers.

## Testing

Some tests for your program are:

| Description                     | Input     | Output                                       |
| :------------------------------ | :-------- | :------------------------------------------- |
| No input                        |           | "Usage: please input a non-negative integer" |
| Empty input                     | ""        | "Usage: please input a non-negative integer" |
| Invalid Input: Not a number     | "asdf"    | "Usage: please input a non-negative integer" |
| Invalid Input: Negative integer | -1        | "Usage: please input a non-negative integer" |
| Sample Input: Zero              | 0         | 1                                            |
| Sample Input: One               | 1         | 1                                            |
| Sample Input: Four              | 4         | 24                                           |
| Sample Input: Eight             | 8         | 40320                                        |
| Sample Input: Ten               | 10        | 3628800                                      |

## Articles

{% include article_list.md collection=site.categories.factorial %}

## Further Reading

- Fill out as needed
