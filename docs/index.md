---
title: Sample Programs in Every Language
layout: default
---

## Welcome to Sample Programs in Every Language

Below you'll find a list of all the available projects:

{% for collection in site.collections %}
  {% for article in collection.docs %}
    {% if article.title contains 'Every Language' %}
  - [{{ article.title }}]({{ article.url | relative_url }})
    {% endif %}
  {% endfor %}
{% endfor %}
