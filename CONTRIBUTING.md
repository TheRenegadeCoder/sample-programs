# Contribute

The goal of this project is to provide a variety of code snippets
for as many languages as possible.

## Repository Structure

Before we get into the contribution rules, we should probably get an understanding for
how this repository is structured.

At the root of the repository, there are several housekeeping files that shouldn't matter
much to the average user. The only item that matters is the archives folder.

Within the archives folder, you'll find a set of one-character folders. Each of these folders contains
a list of language folders that share the same first character as the parent folder.

Within each language folder, you'll find the following:

- A README
- A list of program files.

Now, the program files are self-explanatory. Each one just maps to an ongoing project
that you can find in the General Rules section. As for the README, it contains a list
of the program files that link to existing articles on The Renegade Coder.
In addition, the README contains links to language references and a list of fun facts.

Naturally, if you wish to add a completely new language to the repository, you'll
need to follow this repository structure. Now, let's get to the rules!

## General Rules

If you wish to contribute, simply fork the repo and make a pull request
with your changes. Ideally, your contribution should be to existing projects,
but you're welcome to add new snippets.

However, for simplicity, I ask that you **only make pull requests for one language and one project at a time.**

The following list contains all existing sample programs:

1. [Hello World in Every Language](https://therenegadecoder.com/code/hello-world-in-every-language/)
2. [Reverse a String in Every Language](https://therenegadecoder.com/code/reverse-a-string-in-every-language/)

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

In the section labeled [Insert List of Sample Program Additions Here], please add the name of the
sample program you've added. Don't worry about linking to any articles. I will add those as needed.

In addition, in the section labeled [Insert List of Fun Facts Here], please add fun information
like when the language debuted, who develops the language, and what type system the language uses.

Finally, in the section labeled [Insert Language References Here], please add language references
to the language's README. Acceptable references include Wikipedia pages, official websites, online editors,
and GitHub pages. This helps me determine if the language actually exists, and it helps users who are browsing the repository.

Don't worry if you forget any of this; I have a check list of reminders in the pull request template.

At any rate, let's have some fun!

## Hello World Rules

Hello World is a standard program used to introduce a programming language.
As a result, the rules are pretty simple. For each language, create a program
that writes the string "Hello, World!" to standard output. Ideally, the solution
should be as simple as possible.

## Reverse a String Rules

While Hello World is simple, it often does not show off many interesting
features of a language. Fortunately, this repository shares more samples than
Hello World. One of these more complex programs is known as Reverse a String.

The goal is to reverse a string in the general case. For instance, if a string
contains surrogate pairs, the solution must not corrupt the string during reversal.

### Requirements

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

### Test Cases

| Input | Output |
|-------|---------|
| "" |             |
| "Hello, World" | "dlroW ,olleH" |
| "Les Misérables" | "selbarésiM seL" |
| "字樣樣品" | "品樣樣字" |
