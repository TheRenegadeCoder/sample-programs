{% if include.collection %}
  {% assign sorted_posts = (include.collection | sort: 'title') %}
  {% for article in sorted_posts %}    
    {% unless article.title contains 'Every Language' %}
- [{{ article.title }}]({{ article.url | relative_url }})
    {% endunless %}
  {% endfor %}
{% else %}
Currently, there are no articles. If you'd like to begin contributing, head
over to the repo to get started.
{% endif %}
