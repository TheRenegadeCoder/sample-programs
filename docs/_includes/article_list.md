{% assign sorted_posts = (include.collection | sort: 'title') %}
{% for article in sorted_posts %}    
  {% unless article.title contains 'Every Language' %}
  - [{{ article.title }}]({{ article.url | relative_url }})
  {% endunless %}
{% endfor %}
