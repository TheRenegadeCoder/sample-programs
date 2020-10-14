# Contribute

The goal of this project is to provide a variety of code snippets
for as many languages as possible.

## Table of Contents

-   [Overview][overview]
    -   [Pull Requests][pull-requests]
    -   [Issues][issues]
-   [Repository Structure][repository-structure]
    -   [Archives][archives]
    -   [Test][test]
-   [File Naming Conventions][file-naming-conventions]
    -   [Directories][directories]
    -   [Source Files][source-files]
-   [Pull Requests in Detail][pull-requests-in-detail]
    -   [Claiming an Issue][claiming-an-issue] 
    -   [Add One and Only One Snippet at a Time][add-one-and-only-one-snippet-at-a-time] 
    -   [Requirements for a New Project][requirements-for-a-new-project] 
    -   [Requirements for a New Language][requirements-for-a-new-language] 
-   [Issues in Detail][issues-in-detail]
    -   [Modifying Existing Code Snippets][modifying-existing-code-snippets]
    -   [Modifying Existing Tests][modifying-existing-tests]
-   [Tests in Detail][tests-in-detail]
    -   [Writing Testable Code][writing-testable-code]
    -   [Running Tests Locally][running-tests-locally]
    -   [Adding a testsinfo.yml][adding-a-testinfoyml]
-   [Plagiarism][plagiarism]

## Overview

Any issues or pull requests must adhere to the guidelines below.
Any that do not will be closed.
You will find more detail about each guideline throughout the rest of this document

### Pull Requests

- Pull requests must pass _all_ tests. [More info...][all-tests-must-pass]
- Pull requests for code snippets _must_ match an existing issue. [More info...][claiming-an-issue]
- Pull requests for code snippets _must_ match an existing project. [More info...][requirements-for-a-new-project]
- Pull requests for code snippets in a **new language** must _must_ include a `testinfo.yml` file
  in order to test snippets in the new language. [More info...][add-testinfoyml]
- Pull requests for code snippets in a **new language** _must_ include a `README.md`
  containing information about the language. [More info...][create-readmes]

### Issues

#### Code Snippets
- Issues for code snippets _must_ link to the relevant project.  [More info...][issues-in-detail]
- Issues to fix existing code snippets _must_ explain why an enhancement is _necessary_. [More info...][modifying-existing-code-snippets]

#### Tests

- Issues for tests _must_ link to the relevant project. [More info...][issues-in-detail]
- Issues to modify tests _must_ explain why modification is _necessary_. [More info...][modifying-existing-tests]


## Repository Structure

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
The `testinfo.yml` provides information about the projects in the folder
to our testing library.

Naturally, if you wish to add a completely new language to the repository, you must
follow this repository structure.

### Test

Meanwhile, the test folder contains all the testing related files. Tests are
organized by project and administered through [Glotter][glotter]. This toolkit allows us
to write black-box tests in Python for any programming language. 

To see what projects are already covered, take a peek in the [projects folder][test-projects-folder]. 
There, you'll find each test file which contains the set of valid and invalid tests. 

To create your own tests, see [Tests in Detail][tests-in-detail] below.

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

Naming conventions are important as they help our testing engine, [Glotter][glotter], parse file names.

## Pull Requests in Detail

If you wish to contribute, [fork][fork-a-repo] the repo and make a pull request

Naturally, this repo contains a lot of code snippets.
If you find any that are missing, please add them!
To do so refer to the sections below:

### Claiming an Issue

Start by identifying the [issue][sample-program-issues] for the project and language.
Use our issue labels to make finding the right issue easier.
If an issue does not exist please [create one][issues-in-detail].
Make a comment to claim the issue.
Since we are a small team, it may take a while to acknowledge your claim.
However, if you are the first to comment on an issue, go ahead and begin work.
We will assign issues based on the first person to _comment_.

### Add One and Only One Snippet at a Time

For simplicity, we ask that you **only make pull requests for one language and one project at a time.**

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

### All Tests Must Pass

Generally, if you are implementing a code snippet in a pre-existing language for a pre-existing project, testing is already all setup.
All you need to do is [name your file correctly][file-naming-conventions] and [ensure it has a valid entrypoint][writing-testable-code].
If you are able to, we recommend running the tests locally with the appropriate flags to verify.
See the [running-tests-locally][running-tests-locally] section below for more information.

If you are absolutely unable to run the tests locally,
create a [draft pull request][draft-pull-request] to verify your work before submitting a real pull request for review.

### Requirements for a New Project

#### Add project to Sample Programs Website

This repository contains code snippets that match the [project list on the Sample Programs Website][project-list].
Thus we will only accept code snippets that have a matching project there.

If you believe you have a project that [fits the scope of this project][sample-programs-website],
first make a pull request to [that repository][sample-programs-website].
Once that pull request has been accepted, return here and implement code and tests.

#### Add test for project

If you are the first to implement a solution for a new project or if you come across a project that does not have tests,
you must add tests for your pull request to be accepted.

Add a new test in the [test projects folder][test-projects-folder] named in the format `test_project_name.py`.
See [Tests in Detail][tests-in-detail] below for more information.

### Requirements for a New Language

Occasionally, there will be times when you may want to add a new language to the repo.
When adding new languages, make sure you include a README and setup the language for testing.

#### Create READMEs

Language READMEs should use the following format:

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
language, we track it in its README with links. Check out the [Python README][python-readme]
for an example.

#### Add `testinfo.yml`

In addition to the README, all new languages must be setup for testing.
To do so, add a file called `testinfo.yml` to the new language directory.

Refer to the [Glotter Wiki][glotter-directory-config] and the [Tests in Detail section][tests-in-detail] below
for more information about the contents of that file.

## Issues in Detail

Any issues for code or tests must reference the relevant project.
To do so go to the [Projects List page][projects-list] on the Sample Programs website.
Find the project page from the list of projects there and paste a link to that page into the issue.

For simplicity, we ask that you **only make one issue for one language and one project at a time.**
This and the project link help is tagging and maintaining issues and pull requests.
(See [the pull request section above][add-one-and-only-one-snippet-at-a-time] for the pull request side of this flow)

As such please name the issue in the format "{Add/modify} {project name} in {language}."
For example if I were to add a new snippet for the fibonacci project in python,
I would name my issue "Add Fibonacci in Python".
If I were to modify an existing snippet for the fibonacci project in python,
I would name my issue "Modify Fibonacci in Python".

Issues that are too broad will be closed and or split into multiple issues that follow proper naming format.

### Modifying Existing Code Snippets

The intended purpose of this repository is to promote learning and sharing of programming languages.
In order to do so, we have intentionally selected relatively small projects that can be implemented as simple single file code snippets.
We realize that there are many different ways to implement these projects even within the same language.

Some existing implementations may not be the "best" or "most efficient" implementation.
We are okay with that as long as the code snippet still helps with our goal to promote learning.

That means that **we will not accept issues or pull requests to modify existing snippets**
unless you are able to explain in the issue why the existing implementation does not follow the guidelines specified
in the [project documentation][project-list] or why the existing implementation detracts from the goal of this repository in some way.

If you are making such a claim, we recommend waiting for approval from the core team (`@TheRenegadeCoder/core`) for beginning work on a pull request.

### Modifying Existing Tests

The same general principal applies to tests as it does to code snippets.
That said, tests are not the final product of this repository as the code snippets are.
Please explain in detail why a change needs to be made to tests.
We will likely be less strict about such requests
but still recommend waiting for approval from the core team (`@TheRenegadeCoder/core`) for beginning work that will become a pull requset.


## Tests in Detail

All tests are automatically run as part of the build process for this project.
Running all tests takes some time due to the project.
When making a pull request, please ensure all tests passed in travis.
We cannot merge any pull requests with failing tests.

### Writing Testable Code

Since this project is basically just an enormous collection of related, but isolated files,
we have decided to automate testing using pre-defined test cases as input and checking for expected output.
All programs that require input should take that input as command line arguments.
They should then print the output of the program to the console.
**Each program should print the expected result of the program with no other output.**

To know what input will be tested and what output is expected,
refer to "Testing" section of each [project documentation][project-list].
Each project has a table containing a short name for the test,
the input that will be used for the test and the expected output.

Next, follow the naming conventions specified in the [Naming Conventions][file-naming-conventions] section above.
To see the naming conventions for projects that have existing tests refer to the "words"
list in the [.glotter.yml][project-glotter-yml] and to the `testinfo.yml` file in the language folder.

### Running Tests Locally

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

### Adding a testsinfo.yml

Each project directory should contain a file called `testinfo.yml`.
This file contains information that tell the testing framework how to identify, build, and execute source files in this language.
Refer to the [Glotter Wiki][glotter-directory-config] for detailed information about the structure of the `testinfo.yml` file.

For the container section of the file, we prefer to use [official language images][docker-official-images].
If no official image is available, please try to use one that commonly used by developers in the language
and that is provided by a contributor that you trust.

If no docker image exists for the language at all, please reach out to the core team in your github issue using `@TheRenegadeCoder/core`.

## Plagiarism

**Please** do not submit work that is copied from another source. If work is found to be
plagiarized, the issue must be remedied ASAP. The quickest solution is to cite the source—a citation
in the README would suffice. After that, the solution should be adapted as needed. If necessary, the
solution will be removed at the author's request.

Whenever possible, **please** request the original author to share their solution with this repo. This
keeps the repo tidy by eliminating the need for citations.

These rules help grow and cultivate the community in a positive manner.

[overview]: #overview
[pull-requests]: #pull-requests
[issues]: #issues
[repository-structure]: #repository-structure
[archives]: #archives
[test]: #test
[file-naming-conventions]: #file-naming-conventions
[directories]: #directories
[source-files]: #source-files
[pull-requests-in-detail]: #pull-requests-in-detail
[claiming-an-issue]: #claiming-an-issue
[add-one-and-only-one-snippet-at-a-time]: #add-one-and-only-one-snippet-at-a-time
[all-tests-must-pass]: #all-tests-must-pass
[requirements-for-a-new-project]: #requirements-for-a-new-project
[add-project-to-sample-programs-website]: #add-project-to-sample-programs-website
[add-test-for-project]: #add-test-for-project
[requirements-for-a-new-language]: #requirements-for-a-new-language
[create-readmes]: #create-readmes
[add-testinfoyml]: #add-testinfoyml
[issues-in-detail]: #issues-in-detail
[modifying-existing-code-snippets]: #modifying-existing-code-snippets
[modifying-existing-tests]: #modifying-existing-tests
[tests-in-detail]: #tests-in-detail
[writing-testable-code]: #writing-testable-code
[running-tests-locally]: #running-tests-locally
[adding-a-testinfoyml]: #adding-a-testsinfoyml
[plagiarism]: #plagiarism

[sample-programs-issues]: https://github.com/TheRenegadeCoder/sample-programs/issues

[project-list]: https://sample-programs.therenegadecoder.com/projects/
[glotter]: https://github.com/auroq/glotter
[glotter-wiki]: https://github.com/auroq/glotter/wiki
[glotter-directory-config]: https://github.com/auroq/glotter/wiki/Directory-Level-Configuration
[sample-programs-website]: https://github.com/TheRenegadeCoder/sample-programs-website
[sample-programs-website-contributing]: https://github.com/TheRenegadeCoder/sample-programs-website

[project-glotter-yml]: ../.glotter.yml
[test-projectes-folder]: ../test/projects
[python-readme]: https://github.com/jrg94/sample-programs/blob/master/archive/p/python/README.md

[fork-a-repo]: https://help.github.com/articles/fork-a-repo
[draft-pull-request]: https://github.blog/2019-02-14-introducing-draft-pull-requests/
[docker-official-images]: https://docs.docker.com/docker-hub/official_images/
