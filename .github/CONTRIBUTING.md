# Contribute

The goal of this project is to provide a variety of code snippets
for as many languages as possible.

## Table of Contents

-   [Repository Structure][1]
    -   [Archives][35]
    -   [Test][36]
-   [File Naming Conventions][2]
-   [Pull Requests][4]
    -   [Code][37]
    -   [Tests][43]
-   [Plagiarism][17]

## Repository Structure

Before we get into the contribution rules, we should probably get an understanding of
how this repository is structured.

At the root of the repository, there are several housekeeping files that shouldn't matter
much to the average user. The only items that matter are the archives and the docs folder.

### Archives

Within the archives folder, you'll find a set of one-character folders. Each of these folders contains
a list of language folders that share the same first character as the parent folder.

Within each language folder, you'll find the following:

-   A README
-   A list of project files.
-   A testinfo.yml

Now, each program file maps to an ongoing project that you can find in the Docs directory.
As for the README, it contains a list of the project files that
links to existing articles in the documentation. In addition, the README contains
links to language references and a list of fun facts.
The testinfo.yml provides information about the projects in the folder
to our testing library.

Naturally, if you wish to add a completely new language to the repository, you must
follow this repository structure.

### Test

Meanwhile, the test folder contains all the testing related files. Tests are
organized by project and administered through Glotter. This toolkit allows us
to write black-box tests in Python for any programming language. 

To see what projects are already covered, take a peek in the projects folder. 
There, you'll find each test file which contains the set of valid and invalid
tests. 

To create your own tests, you must either modify the existing test files
or create a new one for a new project. Keep in mind that tests must be written
according to the [project documentation][44]. 

## File Naming Conventions

Before you add any files to the repo, be aware of your file naming conventions.
As you'll see in this section, incorrect naming conventions can cause problems
for some users. 

### Directories

As a general rule, if you're adding a new language, please name the directory
using lowercase alphanumeric character sequences separated by dashes only.
If we do not adhere to this rule, we risk limiting contributors by platform.

For example, let's say someone adds C\* to our repository. If we name the directory
c\*, then Windows users cannot clone the repository. Instead, consider
using c-star. The following table shares a few examples:

| Language | Proper Directory Name |
| -------- | --------------------- |
| C\*      | c-star                |
| C++      | c-plus-plus           |
| C#       | c-sharp               |
| F#       | f-sharp               |

Thanks for keeping this repository inclusive!

### Source Files

Each source file must be named using the filename specified in the project description.
However, the naming convention for the filename (capitalization, hyphenation, etc.)
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

Naming conventions are important as they help our testing engine, Glotter, parse file names.

## Pull Requests

If you wish to contribute, [fork][20] the repo and make a pull request
with your changes. Ideally, your contribution should be in one of two categories:

1. Code
2. Tests

We'll break these down in the following sections.

### Code

Naturally, this repo contains a lot of code snippets. If you find any that are
missing, you're free to add them. However, we are strict in the types of code
snippets you can add. If you're looking for the most up-to-date list of code snippets,
check out the [projects page][44]. All snippets must adhere to the requirements outlined
in their project page. If there's a code snippet you'd like to include that doesn't
currently exist in the list of projects, head over to the [documentation repo][47] to 
define it!

#### Add One and Only One Snippet at a Time

For simplicity, we ask that you **only make pull requests for one
language and one project at a time.**

For instance, let's say you find that the Python collection is missing both
Hello World and Fibonacci, and you'd like to add them both. It would be to
your advantage to then fork the repo and make a branch for each program.

On your Hello World branch, add your sample program and update the
Python README to reflect the change. Then make a pull request.
Because you've made a branch, you won't have to wait for us to approve the change.
You can quickly jump back to master and create a new branch for your next
program.

In this scenario, there will probably be a merge conflict that we can easily
resolve when you make your pull request. This is the ideal workflow for this
repo.

#### Create READMEs for New Languages

Occasionally, there will be times when you may want to add a new language to the repo.
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
article here. At this point, however, the article doesn't exist. Instead, create 
an issue for the article and link the issue here.

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

Don't worry if you forget any of this; we have a checklist of reminders in the
pull request template. At any rate, let's have some fun!

### Tests

All tests are automatically run as part of the build process for this project.
Running all tests takes some time due to the project.
When making a pull request, please ensure all tests passed in travis.
We cannot merge any pull requests with failing tests.

#### Writing Testable Code

Since this project is basically just an enormous collection of related, but isolated files,
we have decided to automate testing using pre-defined test cases as input and checking for expected output.
All programs that require input should take that input as command line arguments.
They should then print the output of the program to the console.
**Each program should print the expected result of the program with no other output.**

To know what input will be tested and what output is expected,
refer to "Testing" section of each [project documentation][44].
Each project has a table containing a short name for the test,
the input that will be used for the test and the expected output.

Next, follow the naming conventions specified in the [Naming Conventions][2] section above.
To see the naming conventions for projects that have existing tests refer to the "words"
list in the [.glotter.yml][46] and to the `testinfo.yml` file in the language folder.

#### Running Tests Locally

To run the tests locally, **you will need the following dependencies**:

- Docker
  - As there are so many languages in this project, we use docker to automatically generate
    consistent, stable build/test environments.
- Python 3.7+
  - We use glotter as our testing library. Make sure you have python installed.
    Then use `pip install -r requirements.txt` (preferably in a virtual environment) to install glotter and its dependencies.

After that, running the tests is a matter of using the following commands:

Starting a test run is done by using python to call `runner.py`.
For windows, this can be done by calling `samplerunner.bat`
On systems with bash installed, just call `./samplerunner.sh`

Running Glotter with no arguments will just print out a help menu.

Some common cases for testing are outlined below.

| Purpose | Command | Example |
| --- | --- | --- |
| Run all tests | `./samplerunner.sh test` | `./samplerunner.sh test` |
| Run all project tests for a given language | `./samplerunner.sh test -l {LANGUAGE_NAME}` | `./samplerunner.sh test -l c-sharp` |
| Run all language tests for a given project | `./samplerunner.sh test -p {PROJECT_KEY}` | `./samplerunner.sh test -p evenodd` |
| Run all tests for a specific program | `./samplerunner.sh test -s {NAME_OF_PROJECT}.{EXTENSION}` | `./samplerunner.sh -s Fibonacci.java` |

#### Writing Tests

Currently, @auroq handles most of the test writing. However, if you would like to contribute your own
test files, get in touch with him. Alternatively, you can use the existing examples to write
your own tests. Be aware that writing tests is a huge process that may or may not result in the
modification of many existing files. 

## Plagiarism

**Please** do not submit work that is copied from another source. If work is found to be
plagiarized, the issue must be remedied ASAP. The quickest solution is to cite the source—a citation
in the README would suffice. After that, the solution should be adapted as needed. If necessary, the
solution will be removed at the author's request.

Whenever possible, **please** request the original author to share their solution with this repo. This
keeps the repo tidy by eliminating the need for citations.

These rules help grow and cultivate the community in a positive manner.

[0]: #please-read
[1]: #repository-structure
[2]: #file-naming-conventions
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
[36]: #test
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
[47]: https://github.com/TheRenegadeCoder/sample-programs-website
