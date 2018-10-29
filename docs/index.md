## Welcome to Sample Programs in Every Language

We are currently migrating sample programs to GitHub pages.

In the meantime, you can read up on the rules:


{% for collection in site.collections %}
  {% for article in collection %}
    - Collection: {{collection}}; Article: {{article}} - [{{ article.title }}]({{ article.url | relative_url }})
  {% endfor %}
{% endfor %}

[1]: hello-world/RULES.md
