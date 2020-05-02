---
title: Even Odd in Every Language
layout: default
date: 2018-11-01
last-modified: 2020-05-02
featured-image: even-odd-in-every-language-featured-image.JPEG
tags: [even-odd]
authors:
  - the_renegade_coder
  - auroq
---

In this article, we'll tackle the even/odd project, its requirements,
and how to test each solution.

## Description

An even number is an integer which is "evenly divisible" by two. This
means that if the integer is divided by 2, it yields no remainder.

An odd number is an integer which is not evenly divisible by two. This
means that if the integer is divided by 2, it yields a remainder of 1.

## Requirements

Create a file called "Even Odd" using the naming
convention appropriate for your language of choice.

Write a sample program which accepts an integer on the command line and
outputs if the integer is Even or Odd.

## Testing

The following table contains various test cases that you can use to verify the correctness of your solution:

| Description                  | Input | Output |
|------------------------------|-------|--------|
| no input                     | None  | Usage: please input a number |
| empty input                  | ""    | Usage: please input a number |
| invalid input: not a number  | a     | Usage: please input a number |
| sample input: even           | 2     | Even |
| sample input: odd            | 5     | Odd |
| sample input: negative even  | -14   | Even |
| sample input: negative odd   | -27   | Odd |

## Articles

{% include article_list.md collection=site.categories.even-odd %}

## Further Reading

- Fill out as needed

[1]: #requirements
