# Contribute

The goal of this project is to provide a variety of code snippets
for as many languages as possible.

## Table of Contents

-   [Repository Structure][1]
  -   [Archives][35]
  -   [Docs][36]
-   [Naming Conventions][2]
-   [Pull Requests][4]
  -   [Code][37]
  -   [Articles][38]
-   [Projects][5]
-   [Plagiarism][17]

## Repository Structure

Before we get into the contribution rules, we should probably get an understanding for
how this repository is structured.

At the root of the repository, there are several housekeeping files that shouldn't matter
much to the average user. The only item that matters is the archives and the docs folder.

### Archives

Within the archives folder, you'll find a set of one-character folders. Each of these folders contains
a list of language folders that share the same first character as the parent folder.

Within each language folder, you'll find the following:

-   A README
-   A list of program files.

Now, each program file maps to an ongoing project that you can find in the
Docs directory. As for the README, it contains a list of the program files that
link to existing articles in the documentation. In addition, the README contains
links to language references and a list of fun facts.

Naturally, if you wish to add a completely new language to the repository, you'll
need to follow this repository structure. Now, let's get to the rules!

### Docs

Meanwhile, the docs folder contains all of the documentation relevant to
the code in the repo. More specifically, we try to write articles for every
code snippet in the repo, so you'll find all of those here.

While the archives folder is organized by language, the docs folder is organized
by project. Each project folder contains a rule set (`index.md`) and a collection
of articles organized by language name.

For example, the `_hello_world` directory contains an `index.md` which houses
the rules for the project and several articles such as:

- `python.md`
- `lisp.md`
- `bash.md`
- etc.

If you plan to add a new project, please make note of the directory structure.

## Naming Conventions

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

## Pull Requests

If you wish to contribute, [fork][20] the repo and make a pull request
with your changes. Ideally, your contribution should be in one of two categories:

1. Code
2. Documentation

We'll break these down in the following sections.

### Code

Naturally, this repo contains a lot of code snippets. If you find any that are
missing, you're free to add them.

However, for simplicity, we ask that you **only make pull requests for one
language and one project at a time.**

For instance, let's say you find that the Python collection is missing both
Hello World and Fibonacci, and you'd like to add them both. It would be to
your advantage to then fork the repo and make a branch for each program.

On your Hello World branch, you should add your sample program and update the
Python README to reflect the change. Then, you should make a pull request.
Because you've made a branch, you won't have to wait for us to approve the change.
You can quickly jump back to master and create a new branch for your next
program.

In this scenario, there will likely be a merge conflict that we can easily
resolve when you make your pull request. This is the ideal workflow for this
repo.

However, there will be times when you may want to add a new language to the repo.
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

In the section labeled `[Insert List of Sample Program Additions Here]`, please
add the name of the sample program you've added. Ideally, you would link to the
article here. At this point, however, the article doesn't exist. Instead, you
should create an issue for the article and link the issue here.

In addition, in the section labeled `[Insert List of Fun Facts Here]`, please
add fun information like when the language debuted, who develops the language,
and what type system the language uses.

Finally, in the section labeled `[Insert Language References Here]`, please add
language references to the language's README. Acceptable references include
Wikipedia pages, style guides, official websites, online editors, and GitHub pages.
This helps us determine if the language actually exists, and it helps users who
are browsing the repository.

If you're feeling adventurous, we're interested in adding a syntax section to each
README. Every time a unique language syntax appears in the repo for a particular
language, we track it in its README with links. Check out the [Python README][13]
for an example.

Don't worry if you forget any of this; we have a check list of reminders in the
pull request template.

At any rate, let's have some fun!

### Articles

As a bonus to this repository, there are associated articles for every script.
However, the articles do take awhile to write, so you can help by writing them
as well.

Previously, we had hosted all of the articles on [The Renegade Coder][34], but
we've since moved away from that to support open-source editing. Now, you
can add and update any article you want.

To get started, you'll want to create a new markdown file (i.e. `python.md`) using
the following template:

```markdown
## <Sample Program> in <Language>

## How to Run Solution

## Sample Programs in Every Language
```

In the `## <Sample Program> in <Language>`, you'll want to break down and
explain your code snippet.

In the `## How to Run Solution`, you'll want to explicitly detail how to run
your solution. In general, we like to include one local solution and one online
solution. More is always appreciated.

Finally, in the `## Sample Programs in Every Language`, you'll want to thank
the readers for sticking around. In addition, you may want to call out
other related works.

If you'd like to add a featured image to any article, you can generate your
own featured image by downloading an image of your choice from Pixabay and
running the [Image Titler][30] program. Then, add the image to the assets
folder, and link it in your article like:

```markdown
![Image Description](Link to Image)
```

And, that's it! We'll review your article once you've made the appropriate
pull request.

## Projects

Below you'll find a list of all the current projects in this repository. Follow
each link to read more about their rules.

-   [Baklava Rules][24]
-   [Convex Hull Rules][29]
-   [Factorial Rules][33]
-   [Fibonacci Sequence Rules][25]
-   [File IO Rules][18]
-   [Fizz Buzz Rules][7]
-   [Game of Life Rules][10]
-   [Hello World Rules][6]
-   [Longest Common Subsequence Rules][28]
-   [Quine Rules][9]
-   [Reverse a String Rules][8]
-   [Roman Numeral Conversion Rules][26]
-   [Even Odd Rules][31]
-   [Prime Number Rules][32]

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

Feel free to browse other projects to get an idea of how to fill out each
section.

Once you've created the file, _please_ link it in this section.

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
[4]: #pull-requests
[5]: #projects
[6]: docs/hello-world/index.md
[7]: docs/fizz-buzz.index.md
[8]: docs/reverse-a-string/index.md
[9]: docs/quine.md
[10]: docs/game-of-life/index.md
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
[24]: docs/baklava/index.md
[25]: docs/fibonacci/index.md
[26]: docs/roman-numeral-conversion/index.md
[28]: docs/longest-common-subsequence/index.md
[29]: docs/convex-hull/index.md
[30]: https://github.com/TheRenegadeCoder/image-titler
[31]: docs/even-odd/index.md
[32]: docs/prime-number/index.md
[33]: docs/factorial/index.md
[34]: https://therenegadecoder.com/code/sample-programs-in-every-language/
[35]: #archives
[36]: #docs
[37]: #code
[38]: #articles
