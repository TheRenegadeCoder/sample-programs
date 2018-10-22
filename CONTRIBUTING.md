# Contribute

The goal of this project is to provide a variety of code snippets
for as many languages as possible.

## Table of Contents

<<<<<<< HEAD
- [Please Read][0]
  - [Repository Structure][1]
  - [Naming Conventions][2]
  - [Articles][3]
  - [Pull Requests][4]
- [Projects][5]
  - [Baklava Rules][24]
  - [Convex Hull Rules][29]
  - [Fibonacci Sequence Rules][25]
  - [File IO Rules][18]
  - [Fizz Buzz Rules][7]
  - [Game of Life Rules][10]
  - [Hello World Rules][6]
  - [Longest Common Subsequence Rules][28]
  - [Quine Rules][9]
  - [Reverse a String Rules][8]
  - [Roman Numeral Conversion][26]
  - [Even Odd Rules][30]
  - [Prime Number Rules][31]
- [Plagiarism][17]
=======
-   [Please Read][0]
    -   [Repository Structure][1]
    -   [Naming Conventions][2]
    -   [Articles][3]
    -   [Pull Requests][4]
-   [Projects][5]
-   [Plagiarism][17]
>>>>>>> 86cedb9aa0c4a780d516f4d0ba52fe56db03094e

## Please Read

In this section, we'll cover some of the essential topics for the repository.

### Repository Structure

Before we get into the contribution rules, we should probably get an understanding for
how this repository is structured.

At the root of the repository, there are several housekeeping files that shouldn't matter
much to the average user. The only item that matters is the archives folder.

Within the archives folder, you'll find a set of one-character folders. Each of these folders contains
a list of language folders that share the same first character as the parent folder.

Within each language folder, you'll find the following:

-   A README
-   A list of program files.

Now, each program file maps to an ongoing project
that you can find in the General Rules section. As for the README, it contains a list
of the program files that link to existing articles on The Renegade Coder.
In addition, the README contains links to language references and a list of fun facts.

Naturally, if you wish to add a completely new language to the repository, you'll
need to follow this repository structure. Now, let's get to the rules!

### Naming Conventions

As a general rule, if you're adding a new language, please use lowercase alphanumeric
character sequences separated by dashes only. If we do not adhere to this rule,
we risk limiting contributors by platform.

For example, let's say someone adds C_ to our repository. If we name the directory
c_, then Windows users will be unable to clone the repository. Instead, consider
using c-star. The following table shares a few examples:

| Language | Proper Directory Name |
| -------- | --------------------- |
| C\*      | c-star                |
| C++      | c-plus-plus           |
| C#       | c-sharp               |
| F#       | f-sharp               |

Thanks for keeping this repository inclusive!

### Articles

As a bonus to this repository, there are associated articles for every script. However, the articles
do take awhile to write, so you can help by writing them as well.

If you wish to help write articles, please [create an account][11]
over on The Renegade Coder. When you're done, let me know in the associated GitHub issue.
That way, I can elevate your privileges, so you can draft your article.

Once everything is setup, make sure you [bookmark the backend][12].
That way, you can quickly get to the area where you can draft articles.

In addition, **anyone who writes an article will be granted collaborator status**, so there's an incentive.

#### Writing Guidelines

When writing articles, try to follow the conventions of other articles in the series (i.e. keep the
same structure). When you're done, let me know in the associated GitHub issue, and
I'll schedule the article for publishing. Don't worry about the featured image;
I'll add one before publishing.

#### Profile

Don't forget to update your profile as it will be displayed at the bottom of the article. If you want
a proper profile image, make sure to setup a [Gravatar][19]
using the same email as your account.

### Pull Requests

If you wish to contribute, [fork][20] the repo and make a pull request
with your changes. Ideally, your contribution should be to existing projects,
but you're welcome to add new snippets.

However, for simplicity, I ask that you **only make pull requests for one language and one project at a time.**

Refer to the table of contents for all available sample programs.

When adding new languages, make sure you include a README using the following template:

```markdown
# Sample Programs in [Insert Language Here]

Welcome to Sample Programs in [Insert Language Here]!

## Sample Programs

- [Insert List of Sample Program Additions Here]

## Fun Facts

- [Insert List of Fun Facts Here]

## References

- [Insert Language References Here]
```

In the section labeled `[Insert List of Sample Program Additions Here]`, please add the name of the
sample program you've added. Ideally, you would link to the article here. At this point, however,
the article doesn't exist. Instead, you should create an issue for the article and link the issue
here.

In addition, in the section labeled `[Insert List of Fun Facts Here]`, please add fun information
like when the language debuted, who develops the language, and what type system the language uses.

Finally, in the section labeled `[Insert Language References Here]`, please add language references
to the language's README. Acceptable references include Wikipedia pages, official websites, online editors,
and GitHub pages. This helps me determine if the language actually exists, and it helps users who are browsing the repository.

If you're feeling adventurous, I'm interested in adding a syntax section to each README. Every time a unique
language syntax appears in the repo for a particular language, we track it in its README with links. Check
out the [Python README][13] for an example.

Don't worry if you forget any of this; I have a check list of reminders in the pull request template.

At any rate, let's have some fun!

## Projects

<<<<<<< HEAD
Below you'll find a list of all the current projects in this repository and their rules.

### Baklava Rules

Baklava is a Turkish dessert, and its shape is like an equilateral quadrangle.
It is used as an example for programming education in Turkish schools. The following
is the expected output:

```
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
```

In general, this solution can be accomplished using a pair of loops. Of course, all
possible programs are welcome.

### Convex Hull Rules

Suppose you have a set of points in the plane. The **convex hull** of this set is the smallest
convex polygon that contains all the points.

A good way to visualize the problem is this: Imagine each point is a nail sticking out of the plane,
and you stretch a rubber band around them and let it go. The band will contract and assume a shape
that encloses the nails. This shape is the convex hull.

![Rubber band visualization](https://upload.wikimedia.org/wikipedia/commons/d/de/ConvexHull.svg)

Note that all vertices of the convex hull are points in the original set. So the convex hull is really
a subset of points from the original set, and there may be points that lie inside the polygon but are
not vertices of the convex hull.

Write a program that receives two command line arguments: strings in the form `x1, x2, x3 ...` and
`y1, y2, y3 ...` respectively, where `(xi, yi)` are the coordinates of the i-th point of the set.

Your program should be able to parse these lists into some internal representation in your choice
language (ideally an array). From there, the program should compute the convex hull of the set of points,
and output a list in the form
```
    (x1, y1)
    (x2, y2)
    ...
```
where `(xj, yj)` are the coordinates of the j-th vertex of the convex hull.

There are many algorithms to solve this problem. You may implement any of them. Check this
[great document by Jeff Erickson](http://jeffe.cs.illinois.edu/teaching/compgeom/notes/01-convexhull.pdf)
for more details about the problem and the different algorithms to solve it.

### Fibonacci Sequence Rules

In mathematics, the Fibonacci numbers are the numbers in the following integer
sequence, called the Fibonacci sequence, and characterized by the fact that
every number after the first two is the sum of the two preceding ones:

    1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, ...

For this sample program, each solution should leverage dynamic programming to produce this
list up to the nth term. For instance, `./fib 5` on the command line should output
```
1: 1
2: 1
3: 2
4: 3
5: 5
```
In addition, there should be some error handling for situations where the user doesn't supply
any input or the user supplies input that is not a number (i.e. `./fib` or `./fib hello`, respectively).

### File IO Rules

Most languages have built-in utilities or functions for reading and writing files.
Many of these input/output functions follow a similar pattern across programming languages:
a string to the path of the file and a "mode". A mode is how the files is opened.
Will the file be opened for reading, writing, or even both?
Will the file be appending new content? Truncated?

In general, a File IO solution should perform the following:

1. Write some arbitrary content to a file (use `output.txt`)
2. Read back that content and print it to the user

More specifically, begin with writing a file to disk. In the write function, you should show how
to open a file with write abilities and write some contents to the file. Before closing the file,
you should ensure everything is written to disk. Then, close the file. There should be basic error
checking to confirm file opening was successful.

With the read file function, open the file with read abilities. Most higher level languages
offer a way to read line by line or even transfer the whole contents into a string. One way
to read the file is to loop line by line and do some processing. Printing each line to the
screen is enough. Like in the write function, make sure there is some basic error checking.

### Fizz Buzz Rules

![Fizz_Buzz][27]

Fizz Buzz is a typical interview question which tests the developers knowledge of
flow control and operators. For the purposes of this repository, the following
rules apply:

> Write a program that prints the numbers 1 to 100. However, for multiples of three,
> print "Fizz" instead of the number. Meanwhile, for multiples of five, print "Buzz"
> instead of the number. For numbers which are multiples of both three and five,
> print "FizzBuzz"
=======
Below you'll find a list of all the current projects in this repository. Follow
each link to read more about their rules.
>>>>>>> 86cedb9aa0c4a780d516f4d0ba52fe56db03094e

-   [Baklava Rules][24]
-   [Convex Hull Rules][29]
-   [Fibonacci Sequence Rules][25]
-   [File IO Rules][18]
-   [Fizz Buzz Rules][7]
-   [Game of Life Rules][10]
-   [Hello World Rules][6]
-   [Longest Common Subsequence Rules][28]
-   [Quine Rules][9]
-   [Reverse a String Rules][8]
-   [Roman Numeral Conversion][26]

If you'd like to add a project, feel free to create a pull request with a new
file containing a project description in the docs folder. The project file
should follow the following template:

```markdown
# [Project Name]

[Insert description of project here]

## Requirements

[Outline program requirements here]

## Testing

[Outline a comprehensive set of tests here]

## Further Reading

- [List useful links here]
```

<<<<<<< HEAD
The longest common subsequence is `1, 4, 5, 6`.

Write a program which accepts two command line arguments--each list--and outputs the longest
common subsequence between the two lists. Input arguments should be in comma separated list notation:
`1, 2, 14, 11, 31, 7, 9`.
=======
Feel free to browse other projects to get an idea of how to fill out each
section.

Once you've created the file, *please* link it in this section.
>>>>>>> 86cedb9aa0c4a780d516f4d0ba52fe56db03094e

## Plagiarism

**Please** do not submit work that is copied from another source. If work is found to be
plagiarized, the issue must be remedied ASAP. The quickest solution is to cite the source--a citation
in the README would suffice. After that, the solution should be adapted as needed. If necessary, the
solution will be removed at the authors request.

Whenever possible, **please** request the original author to share their solution with this repo. This
keeps the repo tidy by eliminating the need for citations.

These rules help grow and cultivate the community in a positive manner.

[0]: #please-read

[1]: #repository-structure

[2]: #naming-conventions

[3]: #articles

[4]: #pull-requests

[5]: #projects

[6]: docs/hello-world.md

[7]: docs/fizz-buzz.md

[8]: docs/reverse-a-string.md

[9]: docs/quine.md

[10]: docs/game-of-life.md

[11]: https://therenegadecoder.com/members/registration/

[12]: https://therenegadecoder.com/wp-admin/

[13]: https://github.com/jrg94/sample-programs/blob/master/archive/p/python/README.md

[17]: #plagiarism

[18]: docs/file-io.md

[19]: https://en.gravatar.com/

[20]: https://help.github.com/articles/fork-a-repo

[21]: https://therenegadecoder.com/code/hello-world-in-every-language/

[22]: https://therenegadecoder.com/code/reverse-a-string-in-every-language/

[23]: https://therenegadecoder.com/series/fizz-buzz-in-every-language/

<<<<<<< HEAD
### Even Odd Rules

An even number is an integer which is "evenly divisible" by two. This means that if the integer is divided by 2,
it yields no remainder.
An odd number is an integer which is not evenly divisible by two. This means that if the integer is divided by 2,
it yields a remainder of 1.

Write a sample program which accepts an integer and outputs if the integer is Even or Odd.

### Prime Number rules

A prime number is a positive integer which is divisible only by 1 and itself.
For example: 2, 3, 5, 7, 11, 13

Since every number is divisible by One so, Two is the only even and the smallest prime number.
Write a sample program which accepts an integer and outputs if the integer is a Prime number or not.

## Plagiarism
=======
[24]: docs/baklava.md
>>>>>>> 86cedb9aa0c4a780d516f4d0ba52fe56db03094e

[25]: docs/fibonacci.md

[26]: docs/roman-numeral-conversion.md

[28]: docs/longest-common-subsequence.md

<<<<<<< HEAD
[0]: #please-read
[1]: #repository-structure
[2]: #naming-conventions
[3]: #articles
[4]: #pull-requests
[5]: #projects
[6]: #hello-world-rules
[7]: #fizz-buzz-rules
[8]: #reverse-a-string-rules
[9]: #quine-rules
[10]: #game-of-life-rules
[11]: https://therenegadecoder.com/members/registration/
[12]: https://therenegadecoder.com/wp-admin/
[13]: https://github.com/jrg94/sample-programs/blob/master/archive/p/python/README.md
[14]: https://en.wikipedia.org/wiki/Quine_(computing)
[15]: https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life
[16]: https://en.wikipedia.org/wiki/Asteroids_(video_game)
[17]: #plagiarism
[18]: #file-io-rules
[19]: https://en.gravatar.com/
[20]: https://help.github.com/articles/fork-a-repo
[21]: https://therenegadecoder.com/code/hello-world-in-every-language/
[22]: https://therenegadecoder.com/code/reverse-a-string-in-every-language/
[23]: https://therenegadecoder.com/series/fizz-buzz-in-every-language/
[24]: #baklava-rules
[25]: #fibonacci-sequence-rules
[26]: #roman-numeral-conversion
[27]: ./assets/Fizz_Buzz.png
[28]: #longest-common-subsequence-rules
[29]: #convex-hull-rules
[30]: #even-odd=rules
[31]: #prime-number-rules
=======
[29]: docs/convex-hull.md
>>>>>>> 86cedb9aa0c4a780d516f4d0ba52fe56db03094e
