---
title: Programming Languages
layout: default
date: 2018-11-01
last-modified: 2018-11-02
categories: [language]
tags:
authors:
  - the_renegade_coder
---

## A Collection of Programming Languages

The following list contains all of the articles we have on the various
programming languages:

{% for article in site.categories.languages %}    
  - [{{ article.title }}]({{ article.url | relative_url }})
{% endfor %}
