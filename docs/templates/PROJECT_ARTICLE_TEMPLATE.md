---
title: <Sample Program> in Every Language
layout: default
date: YYYY-MM-DD
last-modified: YYYY-MM-DD
featured-image: <name of featured image file in assets folder>
tags: [<a list of tags>]
authors:
  - <author username from _data/authors.yml>
---

[Insert intro sentence here]

## Description

[Insert description of project here]

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

