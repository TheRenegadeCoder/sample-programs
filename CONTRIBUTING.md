# Contribute

The goal of this project is to provide a variety of code snippets
for as many languages as possible.

## Table of Contents

- [Please Read][0]
  - [Repository Structure][1]
  - [Naming Conventions][2]
  - [Articles][3]
  - [Pull Requests][4]
- [Projects][5]
  - [Hello World Rules][6]
  - [Fizz Buzz Rules][7]
  - [Reverse a String Rules][8]
  - [File IO Rules][18]
  - [Quine Rules][9]
  - [Game of Life Rules][10]
- [Plagiarism][17]

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

- A README
- A list of program files.

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

For example, let's say someone adds C* to our repository. If we name the directory
c*, then Windows users will be unable to clone the repository. Instead, consider
using c-star. The following table shares a few examples:

| Language | Proper Directory Name |
|----------|------------------|
| C* | c-star |
| C++ | c-plus-plus |
| C# | c-sharp |
| F# | f-sharp |

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

The following list contains all existing sample programs:

1. [Hello World in Every Language][21]
2. [Reverse a String in Every Language][22]
3. [Fizz Buzz in Every Language][23]
4. File IO in Every Language
5. Quine in Every Language
6. Game of Life in Every Language

When adding new languages, make sure you include a README using the following template:

```
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

Below you'll find a list of all the current projects in this repository and their rules.

### Hello World Rules

Hello World is a standard program used to introduce a programming language.
As a result, the rules are pretty simple. For each language, create a program
that writes the string "Hello, World!" to standard output. Ideally, the solution
should be as simple as possible.

### Fizz Buzz Rules

Fizz Buzz is a typical interview question which tests the developers knowledge of
flow control and operators. For the purposes of this repository, the following
rules apply:

> Write a program that prints the numbers 1 to 100. However, for multiples of three,
> print "Fizz" instead of the number. Meanwhile, for multiples of five, print "Buzz"
> instead of the number. For numbers which are multiples of both three and five,
> print "FizzBuzz"

I was tempted to open this up such that the user could supply any number, but I think
we get plenty of IO with some of the other projects in this repo.

### Reverse a String Rules

While Hello World is simple, it often does not show off many interesting
features of a language. Fortunately, this repository shares more samples than
Hello World. One of these more complex programs is known as Reverse a String.

In this repository, the algorithm must reverse ASCII strings. Do **NOT**
worry about reversing a string in the general case. For instance, if a string
contains surrogate pairs, it's okay if the solution corrupts the string during reversal.

#### Requirements

Despite the explicit name, there are some rules in place for consistency.
When writing a Reverse a String program, the following rules should apply:

1. The implementation must be executable
2. The string to be reversed must come from the command line
3. The program must verify the strings existence on the command line
4. The user must not import libraries to obfuscate the string manipulation

In other words, the program should get a string from the command line and
reverse it using language utilities only. Acceptable language utilities include
language features and built-in libraries.

External dependencies are unacceptable. Remember, the goal is to show off language
features and utilities.

#### Test Cases

If the solution passes these test cases, then it's a good fit for the repo.
Feel free to test other strings for fun. For instance, you may find that
your language can handle unicode characters, but it fails for emojis.

Description  | Input          | Output
-------------|:--------------:|:---------:
No Input     |                |
Empty String | ""             |             
Ascii String | "Hello, World" | "dlroW ,olleH"

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

### Quine Rules

For those of you that don't know, a quine is a program which can replicate
itself--or more specifically:

> A quine is a non-empty computer program which takes no input and produces a
> copy of its own source code as its only output.

Thanks, [Wikipedia][14]!

For the purposes of this repo, the solution should be simple. We're not here
to play code golf, but we're also not here to practice obfuscation. Just be
reasonable with your solution.

### Game of Life Rules

For those of you that don't know, the Game of Life is basically a cell
simulation where cells are arranged in an infinite grid. Each cell has one
of two states: alive or dead.

At each turn, all cells are evaluated using the following rules:

- Any live cell with fewer than two live neighbors dies, as if caused by underpopulation.
- Any live cell with two or three live neighbors lives on to the next generation.
- Any live cell with more than three live neighbors dies, as if by overpopulation.
- Any dead cell with exactly three live neighbors becomes a live cell, as if by reproduction.

For more information, check out the [Wikipedia page for Conway's Game of Life][15].

Of course, for the purposes of the repo, here are the requirements for a contribution:

1. Source code must fit in a single file
2. Grid must wrap-around on the edges (think [asteroids][16])
3. The program must support the following command line arguments
    - Grid width (assume square grid)
    - Frame rate (frames/second)
    - Total number of frames
    - Spawn rate (% of living vs. dead as decimal between 0 and 1)
4. Simulation must be a GUI
    - An exception to this rule can be made for languages where it's impossible
      or impractical to have an actual GUI. In that case, a terminal application
      is sufficient.

Beyond that, there's really no hard-and-fast requirements. All I ask is that
solutions are minimal. In other words, don't worry about command line options or
GUI elements. Keep it simple. Remember, the goal is to show off language features.

Also, I ask that you don't use external libraries. I like for these files to
be as easy as possible to test, so limiting dependencies is helpful.

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
