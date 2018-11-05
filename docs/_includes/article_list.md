{% assign date = page.date | date_to_long_string }
{% assign author = page.authors | first %}
{% assign author = site.data.authors[author].name %}
{% if include.collection %}
  {% assign sorted_posts = (include.collection | sort: 'title') %}
  {% for article in sorted_posts %}    
    {% unless article.url == page.url %}
- [{{ article.title }}]({{ article.url | relative_url }}) on {{ date }} by {{ author }}
    {% endunless %}
  {% endfor %}
{% else %}
Currently, there are no articles. If you'd like to begin contributing, head
over to the repo to get started.
{% endif %}
