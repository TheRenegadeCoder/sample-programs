{% assign sorted_posts = (site.categories.languages | sort: 'title') %}
{% for article in sorted_posts %}    
  - [{{ article.title }}]({{ article.url | relative_url }})
{% endfor %}
