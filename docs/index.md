## Welcome to Sample Programs in Every Language

We are currently migrating sample programs to GitHub pages.

In the meantime, you can read up on the rules:


{% for collection in site.collections %}
  {% for article in collection %}
    {% if article.title == "Hello World in Every Language" %}
      - [{{ article.title }}]({{ article.url | relative_url }})
    {% endif %}
  {% endfor %}
{% endfor %}

[1]: hello-world/RULES.md
