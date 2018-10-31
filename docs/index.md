---
title: Sample Programs in Every Language
layout: default
---

## Sample Programs in Every Language

Welcome to Sample Programs in Every Language, a collection of code snippets
in as many languages as possible. Thanks for taking an interest in our project!

Currently, our documentation is organized in two ways: by project or by language.
Feel free to browse the appropriate section for you below.

## Projects

Below you'll find a list of all the available projects:

{% for collection in site.collections %}
  {% for article in collection.docs %}
    {% if article.title contains 'Every Language' %}
  - [{{ article.title }}]({{ article.url | relative_url }})
    {% endif %}
  {% endfor %}
{% endfor %}

## Languages

In addition, you can also browse the collection by language:

- {{ site.languages.url | relative_url }}
