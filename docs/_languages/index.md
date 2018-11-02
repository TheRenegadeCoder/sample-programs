---
title: Programming Languages
layout: default
date: 2018-11-01
authors:
  - the_renegade_coder
---

## A Collection of Programming Languages

The following list contains all of the articles we have on the various
programming languages:

{% for article in site.languages %}    
  {% unless article.title == "Programming Languages" %}
  - [{{ article.title }}]({{ article.url | relative_url }})
  {% endunless %}
{% endfor %}
