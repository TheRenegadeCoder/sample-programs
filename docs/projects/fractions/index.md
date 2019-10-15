---
title: Fractions in Every Language
layout: default
date: 2019-10-10
last-modified: 2019-10-10
feature-image:
tags: [fractions]
authors:
---

In this article, we'll tackle fractions in every language.

## Description

Languages like python have built-in utilities or functions for working with fractions.
Many of these fractions functions follow a similar pattern across programming languages: 
takes a numerator and a denomenator as an attribute.
Perform basic arithmatic and relational operations with operator overloading.

## Requirements

In general, a fractions library should perform the following:

1. Perform arithmatic operation like multiplications, addition etc.
2. Give output for relational operations like >=, >, == etc.

More specifically, begin with creating object instance of fraction class with two attributes:
numerator and denomenator.Using operator overloading feature of langauge implement basic arithmatic
and relational operaions.

For instance `./fractions "6/2" "+" "1/4"` would output `13/4`

In addition, there should be some error handling for situations where the user
doesn't supply any input.


## Testing
Some tests for your program are:

| Description | Input | Output |
| :---------- | :---- | :----- |
| No Input                    |      | "Usage: ./fractions operand1 operator operand2" |
| Empty Input                 | ""   | "Usage: ./fractions operand1 operator operand2" |
| Sample Input: | 2/3 + 4/5 | 22/15 |
| Sample Input: | 2/3 * 4/5  | 8/15 |
| Sample Input: | 2/3 - 4/5  | -2/15 |
| Sample Input: | 2/3 / 4/5  | 5/6 |
| Sample Input: | 2/3 == 4/5 | 0 |
| Sample Input: | 2/3 > 4/5 | 0 |
| Sample Input: | 2/3 < 4/5 | 1 |
| Sample Input: | 2/3 >= 4/5 | 0 |
| Sample Input: | 2/3 <= 4/5 | 1 |
| Sample Input: | 2/3 != 4/5 | 1 |

## Articles

{% include article_list.md collection=site.categories.fractions %}
