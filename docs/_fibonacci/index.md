---
title: Fibonacci in Every Language
layout: default
---

# Fibonacci

In mathematics, the Fibonacci numbers are the numbers in the following integer
sequence, called the Fibonacci sequence, and characterized by the fact that
every number after the first two is the sum of the two preceding ones:

    1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, ...

## Requirements

For this sample program, each solution should leverage dynamic programming to produce this
list up to the nth term. For instance, `./fib 5` on the command line should output

```
1: 1
2: 1
3: 2
4: 3
5: 5
```

In addition, there should be some error handling for situations where the user
doesn't supply any input or the user supplies input that is not a number
(i.e. `./fib` or `./fib hello`, respectively).

## Testing

Verify that the actual output matches the expected output. See the
[requirements][1] section for an example of the expected output.

## Articles

{% for article in site.fibonacci %}    
  {% unless article.title contains 'Every Language' %}
  - [{{ article.title }}]({{ article.url | relative_url }})
  {% endunless %}
{% endfor %}

## Further Readings

- Fill as needed

[1]: #requirements
