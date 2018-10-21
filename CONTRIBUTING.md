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

Refer to the table of contents for all available sample programs.

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
[28]: #longest-common-subsequence-rules
[29]: #convex-hull-rules
