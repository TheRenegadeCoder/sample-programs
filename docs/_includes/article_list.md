{% for article in include.collection %}    
  {% unless article.title contains 'Every Language' %}
  - [{{ article.title }}]({{ article.url | relative_url }})
  {% endunless %}
{% endfor %}
