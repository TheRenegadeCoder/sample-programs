---
title: Binary Search in Every Language
layout: default
date: 2019-10-25
last-modified: 2019-10-25
featured-image: 
tags: [binary-search]
authors:
  - the_renegade_coder
---

In this article, we lay out all the requirements for a binary search program.

## Description

Binary search is a special type of search function which relies on a few properties
of the search space. First, the search space must have constant time random access
(i.e. an array). In addition, the search space must be sorted by some attribute.
As a consequence, we're able to navigate the search space in O(log(N)) instead of
O(N). 

Jargon aside, binary search works by taking advantage of a sorted collection. As a result,
we don't have to search every element in the collection. Instead, we can try the middle.
If the middle element is greater than the element we want to find, we know that the element
must be "to the left" of that element—assuming the collection is sorted least to greatest. 
From there, we can try the element in the middle of the left half, and so on. 

Eventually, we'll find the element we're looking for, or we'll reach the end of our search.
In either case, we'll only explore O(log(N)) elements. This gives us a dramatic improvement
over linear search.

## Requirements

For the purposes of this project, we'll assume that the search space is a list of integers.
Specifically, we'll accept two inputs on the command line: the list of integers and the
integer to find:

```shell
./binary-search.lang "1, 4, 5, 11, 12" "4"
```

If successful, the script should return `true`. Otherwise, the script should return `false`. 
If any user input errors occur, the script should output the following usage message:
"Usage: please provide a list of integers ("1, 4, 5, 11, 12") and the integer to find ("11")".

## Testing

[Outline a comprehensive set of tests here]

## Articles

{% include article_list.md collection=site.categories.[name of project] % }

## Further Reading

- [List useful links here]

---

#### References

{% include reference.md reference="reference_id" %}
