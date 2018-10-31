{% if include.image %}
![{{ include.name }}]({{site.baseurl}}/assets/{{ include.image }})
{% else %}
![{{ include.name }}]({{site.baseurl}}/assets/sample-programs-in-every-language-featured-image.JPEG)
{% endif %}
