{% if include.reference %}
  {% assign ref_data = include.reference %}
  {% assign author_array = ref_data.author | split: " " %} 
  {% assign author = ref_data.author | slice: 0 | append: ". " | append: author_array.last %}
  {% assign title = ref_data.title %}
  {% assign pub = ref_data.publisher %}
  {% assign pub_date = ref_data.publish_date %}
  {% assign url = ref_data.url %}
  {% assign acc_date = ref_data.access_date %}
{{ author }}, "{{ title }}," {{ pub }}, {{ pub_date }}. [Online]. Available: <{{ url }}>. [Accessed: {{ acc_date }}].
{% endif %}
