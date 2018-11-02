---
title: Hello World in R
layout: default
date: 2018-11-01
last-modified: 2018-11-01
featured-image: hello-world-in-r-featured-image.JPEG
tags: [r]
authors:
  - alexandra_woerner
---

{% include featured_image.md name=page.title image=page.featured-image %}

## Hello World in R<sup>1</sup>

Fortunately, this task can be solved in a concise one-liner:

```r
cat("Hello, World!")
```

You can see the string Hello, World! as the argument of the function cat.
This function does all the work. If you are familiar with Bash, you may already
know the cat tool which prints the content of one or several files.

Analogously, you can pass one or several strings to the cat function which prints
the input to the standard output. The function allows an optional argument sep
that represents the separator to use when you pass multiple strings. As a
consequence, the following is an equivalent alternative to the solution above:

```r
cat("Hello", "World!", sep=", ")
```

In this call, Hello and World! are glued together by placing the specified
separator “, ” between the two strings, resulting in the desired output
Hello, World!.

Now, we know what we need to produce the output. The next section explains how
we can also see the output of our program.

## How to Run the Solution<sup>1</sup>

In order to run the solution we need an [R compiler][3] first. Furthermore, we need
a copy of Hello World in R. From within the directory in which we saved the copy,
we run the following command on the command line:

```console
Rscript hello-world.R        # Linux/Unix
R.exe hello-world.R          # Windows
```

Alternatively, you can try an [online compiler][4] if you want to save the time
required for installing the R environment locally.

---

#### References

1. A. Wörner, “Hello World in R,” The Renegade Coder, 17-Sep-2018.
  [Online]. Available: <https://therenegadecoder.com/code/hello-world-in-r/>.
  [Accessed: 02-Nov-2018].


[3]: https://www.r-project.org/
[4]: http://rextester.com/l/r_online_compiler
