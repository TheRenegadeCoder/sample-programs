{% if include.reference and include.id %}
  {% assign id = include.id %}
  {% assign ref_data = include.reference %}
  {% assign author_array = ref_data.author | split: " " %} 
  {% assign author = ref_data.author | slice: 0 | append: ". " | append: author_array.last %}
[^{{ id }}]: {{ author }} 
{% endif %}
