---
title: Capitalize in Every Language
layout: default
date: 2019-03-31
last-modified: 2019-03-31
featured-image:
tags: [capitalize]
authors: 
 - daniellunsc
 - the_renegade_coder
---

In this article, we'll tackle the Capitalize program, its requirements, and how
to test it.

## Description

This simple program picks a string and return the first letter of it in uppercase.

## Requirements

For this sample program, each solution should return the string with the first letter in uppercase.
In other words, do not change anything else about the input string.

```
string -> String
react -> React
java -> Java
car -> Car
a long string term -> A long string term
```

In addition, there should be some error handling for situations where the user
doesn't input a string.

## Testing

Feel free to use the following table when testing capitalize programs

| Description | Input | Output |
|-------------|-------|--------|
| No input | | `Usage: please provide a string` |
| Empty input | `""` | `Usage: please provide a string` |
| Lowercase String | `hello` | `Hello` |
| Uppercase String | `Hello` | `Hello` |
| Long String | `hello world` | `Hello world` |
| Mixed Casing | `heLLo World` | `HeLLo World` |
| Symbols | `12345` | `12345` |

## Articles

{% include article_list.md collection=site.categories.capitalize %}

## Further Reading

- Fill out as needed

[1]: #requirements
