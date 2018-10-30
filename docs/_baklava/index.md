---
title: Baklava in Every Language
layout: default
---

# Baklava

Baklava is a Turkish dessert, and its shape is like an equilateral quadrangle.
It is used as an example for programming education in Turkish schools.

In general, this solution can be accomplished using a pair of loops. Of course, all
possible programs are welcome.

## Requirements

The following is the expected output
(it isn't mandatory to use '\*', any symbol or character can be used):

               *
              ***
             *****
            *******
           *********
          ***********
         *************
        ***************
       *****************
      *******************
     *********************
      *******************
       *****************
        ***************
         *************
          ***********
           *********
            *******
             *****
              ***
               *

1.  The shape should be symmetrical both horizontally and vertically
2.  Each subsequent line should either add or remove padding by one character on both sides
3.  Whitespace should be adjusted accordingly in order to properly output the shape

## Testing

Verify that the actual output matches the expected output (see [requirements][1])

## Articles

{% for article in site.hello_world %}    
  {% unless article.title contains 'Every Language' %}
  - [{{ article.title }}]({{ article.url | relative_url }})
  {% endunless %}
{% endfor %}

## Further Reading

To be added later when article is made

[1]: #requirements
