---
title: Factorial in Every Language
layout: default
---

# Factorial

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

| Description      | Input     | Output                                       |
| :--------------: | :-------: | :------------------------------------------: |
| Empty input      |           | "Usage: please input a non-negative integer" |
| Not a number     | "asdf"    | "Usage: please input a non-negative integer" |
| Negative integer | -1        | "Usage: please input a non-negative integer" |
| Zero             | 0         | 1                                            |
| Positive integer | 1         | 1                                            |
| Positive integer | 4         | 24                                           |
| Positive integer | 8         | 40320                                        |
| Positive integer | 10        | 3628800                                      |

## Articles

{% for article in site.factorial %}    
  {% unless article.title contains 'Every Language' %}
  - [{{ article.title }}]({{ article.url | relative_url }})
  {% endunless %}
{% endfor %}

## Further Reading

- Fill out as needed
