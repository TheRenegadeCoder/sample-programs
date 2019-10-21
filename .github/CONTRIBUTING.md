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
    -   [Tests][43]
-   [Plagiarism][17]

## Repository Structure

Before we get into the contribution rules, we should probably get an understanding of
how this repository is structured.

At the root of the repository, there are several housekeeping files that shouldn't matter
much to the average user. The only items that matters are the archives and the docs folder.

### Archives

Within the archives folder, you'll find a set of one-character folders. Each of these folders contains
a list of language folders that share the same first character as the parent folder.

Within each language folder, you'll find the following:

-   A README
-   A list of project files.
-   A testinfo.yml

Now, each program file maps to an ongoing project that you can find in the Docs directory.
As for as the README, it contains a list of the project files that
links to existing articles in the documentation. In addition, the README contains
links to language references and a list of fun facts.
The testinfo.yml provides information about the projects in the folder
to our testing library.

Naturally, if you wish to add a completely new language to the repository, you'll
need to follow this repository structure.

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

### Directories

As a general rule, if you're adding a new language, please name the directory
using lowercase alphanumeric character sequences separated by dashes only.
If we do not adhere to this rule, we risk limiting contributors by platform.

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

### Source Files

Each source file must be named using the file name specified in the project description.
However, the naming convention for the filename (capitalization, hyphenation, etc...)
should follow the industry standard for each language. If you are unsure of the naming
convention for a given language, check the `testinfo.yaml` file found in the language directory.

The following table shows examples of how to name a source file for the Even Odd Project
for each naming convention:

| Convention | Source Name |
| ---------- | ----------- |
| camel      | evenOdd.sh  |
| hyphen     | even-odd.sh |
| lower      | evenodd.sh  |
| pascal     | EvenOdd.sh  |
| underscore | even_odd.sh |

## Pull Requests

If you wish to contribute, [fork][20] the repo and make a pull request
with your changes. Ideally, your contribution should be in one of three categories:

1. Code
2. Articles
3. Projects

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
However, the articles do take a while to write, so you can help by writing them
as well.

Previously, we had hosted all of the articles on [The Renegade Coder][34], but
we've since moved away from that to support open-source editing. Now, you
can add and update any article you want.

Currently, there are three types of articles you can write: code, project and
language. You can find out more about this type of articles below.

#### Code

To get started, you'll want to create a new markdown file (eg: `python.md`)
using the [CODE_ARTICLE_TEMPLATE][40] in the docs/projects folder of your
choice.

Make sure you populate the top section (aka the Front Matter) before you're done.

In the top section, you'll want to break down and explain your code snippet.

In the `## How to Run Solution`, you'll want to explicitly detail how to run
your solution. In general, we like to include one local solution and one online
solution. More is always appreciated.

Finally, in the `#### References`, you'll want to place your IEEE citations.
We'd like to keep things relatively formal, so if you borrow content, please
properly cite it here.

If you'd like to add a featured image to any article, you can generate your
own featured image by downloading an image of your choice from Pixabay and
running the [Image Titler][30] program. Then, add the image to the assets
folder, and link it in your article via the `featured-image` tag in the
Front Matter.

And, that's it! We'll review your article once you've made the appropriate
pull request.

#### Projects

Currently, you can find a list of projects on our [project homepage][39].

If you'd like to add a project, feel free to create a pull request with a new
file containing a project description in the docs/projects folder. The project file
should follow the [PROJECT_ARTICLE_TEMPLATE.md][41].

Feel free to browse other projects to get an idea of how to fill out each
section.

#### Languages

Finally, you can also introduce a new language article. To do so, add a new
`<languag>.md` file to the docs/languages folder using the
[LANGUAGE_ARTICLE_TEMPLATE.md][42].

Feel free to look at other articles in the collection for inspiration on how
to fill out that template.

## Tests

All tests are automatically run as part of the build process for this project.
Running all tests does take some time due to the nature of the project.
When making a pull request, please ensure all tests passed in travis.
We cannot merge any pull requests with failing tests.

### Writing Testable Code

Since this project is basically just a large collection of related, but isolated files,
we have decided to automate testing using predefined test cases as input and checking for expected output.
All programs that require input should take that input as command line arguments.
They should then print the output of the program to the console.
**Each program should print the expected result of the program with no other output.**

To know what input will be tested and what output is expected,
refer to "Testing" section of each [project documentation][44].
Each project has a table containing a short name for the test,
the input that will be used for the test and the expected output.

Next make sure to follow the naming conventions specified in the [Naming Conventions][2] section above.
To see the naming conventions for projects that have existing tests refer to the "words"
list in the [.glotter.yml][46] and to the `testinfo.yml` file in the language folder.

### Running Tests Locally

#### Dependencies

- Docker
  - As there are so many languages contained in this project, we use docker to automatically generate
    consistent, stable build/test environments.
- Python 3.7+
  - We use glotter as our testing library. Make sure you have python installed.
    Then use `pip install -r requirements.txt` (preferably in a virtual environment) to install glotter and its dependencies.

#### Starting a test run

Starting a test run is done by using python to call `runner.py`.
For windows, this can be done by calling `samplerunner.bat`
On systems with bash installed, just call `./samplrunner.sh`

Running Glotter with no arguments will just print out a help menu.

Some common cases for testing are outlined below.

| Purpose | Command | Example |
| --- | --- | --- |
| Run all tests | `./samplrunner.sh test | `./samplerunner.sh test` |
| Run all project tests for a given language | `./samplrunner.sh test -l {LANGUAGE_NAME}` | `./samplerunner.sh test -l c-sharp` |
| Run all language tests for a given project | `./samplrunner.sh test -p {PROJECT_KEY}` | `./samplerunner.sh test -p evenodd` |
| Run all tests for a specific program | `./samplrunner.sh test -s {NAME_OF_PROJECT}.{EXTENSION}` | `./samplerunner.sh -s Fibonacci.java` |


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
[6]: ../docs/hello-world/index.md
[7]: ../docs/fizz-buzz.index.md
[8]: ../docs/reverse-a-string/index.md
[9]: ../docs/quine.md
[10]: ../docs/game-of-life/index.md
[11]: https://therenegadecoder.com/members/registration/
[12]: https://therenegadecoder.com/wp-admin/
[13]: https://github.com/jrg94/sample-programs/blob/master/archive/p/python/README.md
[17]: #plagiarism
[18]: ../docs/file-io.md
[19]: https://en.gravatar.com/
[20]: https://help.github.com/articles/fork-a-repo
[21]: https://therenegadecoder.com/code/hello-world-in-every-language/
[22]: https://therenegadecoder.com/code/reverse-a-string-in-every-language/
[23]: https://therenegadecoder.com/series/fizz-buzz-in-every-language/
[24]: ../docs/baklava/index.md
[25]: ../docs/fibonacci/index.md
[26]: ../docs/roman-numeral-conversion/index.md
[28]: ../docs/longest-common-subsequence/index.md
[29]: ../docs/convex-hull/index.md
[30]: https://github.com/TheRenegadeCoder/image-titler
[31]: ../docs/even-odd/index.md
[32]: ../docs/prime-number/index.md
[33]: ../docs/factorial/index.md
[34]: https://therenegadecoder.com/code/sample-programs-in-every-language/
[35]: #archives
[36]: #docs
[37]: #code
[38]: #articles
[39]: https://therenegadecoder.github.io/sample-programs
[40]: ../docs/templates/CODE_ARTICLE_TEMPLATE.md
[41]: ../docs/templates/PROJECT_ARTICLE_TEMPLATE.md
[42]: ../docs/templates/LANGUAGE_ARTICLE_TEMPLATE.md
[43]: #tests
[44]: https://sample-programs.therenegadecoder.com/projects/
[45]: https://sample-programs.therenegadecoder.com/projects/factorial/
[46]: ../.glotter.yml
