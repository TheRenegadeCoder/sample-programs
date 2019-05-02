{% if include.reference and include.id %}
  {% assign id = include.id %}
  {% assign ref_data = include.reference %}
  {% assign author_array = ref_data.author | split: " " %} 
  {% assign author = ref_data.author | slice: 0 | append: ". " | append: author_array.last %}
  {% assign title = ref_data.title %}
  {% assign pub = ref_data.publisher %}
[^{{ id }}]: {{ author }}, "{{ title }}," {{ pub }},
{% endif %}
