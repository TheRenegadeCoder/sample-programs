## Welcome to Sample Programs in Every Language

We are currently migrating sample programs to GitHub pages.

In the meantime, you can read up on the rules:

{% for collection in site.collections %}
  - [{{ collection.label | replace: '_', ' ' | capitalize} }}]({{ collection.url | relative_url }})
{% endfor %}

{% for article in site.hello_world %}
  - [{{ article.title }}]({{ article.url | relative_url }})
{% endfor %}

[1]: hello-world/RULES.md
