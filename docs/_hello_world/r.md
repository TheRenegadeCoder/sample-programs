---
title: Hello World in R
layout: default
---

Welcome to another issue of the Hello World in Every Language series.
This time, we will have a look at an implementation of Hello World in R
thanks to Alexandra Wörner.

## R Background

R is a language as well as an environment especially suited for statistical
computing, data analysis and data visualisation. The first version of this
GNU project was released in 1995.[1] The last major version 3.0 was reeased in
2013.

R enjoys a high popularity in academia and has a large community which both
develops the language and releases new extensions. As a result, CRAN emerged as
a rich archive of packages extending the base functionality of R.

In case you are interested in more information on the history and features of R,
take a look at the R project website from which this short summary originates.

## Hello World in R

Fortunately, this task can be solved in a concise one-liner:

cat("Hello, World!")
You can see the string Hello, World! as the argument of the function cat.
This function does all the work. If you are familiar with Bash, you may already
know the cat tool which prints the content of one or several files.

Analogously, you can pass one or several strings to the cat function which prints
the input to the standard output. The function allows an optional argument sep
that represents the separator to use when you pass multiple strings. As a
consequence, the following is an equivalent alternative to the solution above:

cat("Hello", "World!", sep=", ")

In this call, Hello and World! are glued together by placing the specified
separator “, ” between the two strings, resulting in the desired output
Hello, World!.

Now, we know what we need to produce the output. The next section explains how
we can also see the output of our program.

## How to Run the Solution

In order to run the solution we need an R compiler first. Furthermore, we need
a copy of Hello World in R. From within the directory in which we saved the copy,
we run the following command on the command line:

Rscript hello-world.R        # Linux/Unix
R.exe hello-world.R          # Windows

Alternatively, you can try an online compiler if you want to save the time
required for installing the R environment locally.

## Sample Programs in Every Language

In addition to many other programming languages, we can now also write
Hello, World! in R. How about that! Stay tuned for the this series’ next
installment!

As always, you can share your thoughts below in the comments. If you liked what
you read today, consider sharing it with your friends, colleagues, book club,…
We appreciate your feedback!
