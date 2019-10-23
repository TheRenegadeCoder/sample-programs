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

## Requirements

[Outline program requirements here]

## Testing

[Outline a comprehensive set of tests here]

## Articles

{% include article_list.md collection=site.categories.[name of project] % }

## Further Reading

- [List useful links here]

---

#### References

{% include reference.md reference="reference_id" %}
