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
3. Game of Life in Every Language

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

At the bare minimum, the algorithm must reverse ASCII strings. However,
the goal should be to reverse a string in the general case. For instance, if a string
contains surrogate pairs, the solution should not corrupt the string during reversal.
Of course, this may not be practical in lower level languages like C, so
just be reasonable.

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

If the solution passes at least the first three test cases, then it's a good fit for the repo.
The remaining strings are bonus. Please place an note in the README if the solution
only covers ASCII (i.e. [JavaScript](https://github.com/jrg94/sample-programs/blob/master/archive/j/javascript/README.md)).

| Description| Input | Output |
|------------|:-------:|:---------:|
| No Input | | |
| Empty String | "" |             |
| Ascii String | "Hello, World" | "dlroW ,olleH" |
| Accented String | "Les Misérables" | "selbarésiM seL" |
| Chinese String | "字樣樣品" | "品樣樣字" |
| Emoji String | "If this works: 🤑; If not: 😰" | "😰 :ton fI ;🤑 :skrow siht fI" |

## Game of Life Rules

For those of you that don't know, the Game of Life is basically a cell
simulation where cells are arranged in an infinite grid. Each cell has one
of two states: alive or dead.

At each turn, all cells are evaluated using the following rules:

- Any live cell with fewer than two live neighbors dies, as if caused by underpopulation.
- Any live cell with two or three live neighbors lives on to the next generation.
- Any live cell with more than three live neighbors dies, as if by overpopulation.
- Any dead cell with exactly three live neighbors becomes a live cell, as if by reproduction.

For more information, check out the [Wikipedia page for Conway's Game of Life](https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life).

Of course, for the purposes of the repo, here are the requirements for a contribution:

1. Source code must fit in a single file
2. Grid must wrap-around on the edges (think [asteroids](https://en.wikipedia.org/wiki/Asteroids_(video_game)))
3. The program must support the following command line arguments
    - Grid width (assume square grid)
    - Frame rate (frames/second)
    - Total number of frames
    - Spawn rate (% of living vs. dead as decimal between 0 and 1)
4. Simulation must be a GUI

Beyond that, there's really no hard-and-fast requirements. All I ask is that
solutions are minimal. In other words, don't worry about command line options or
GUI elements. Keep it simple. Remember, the goal is to show off language features.

Also, I ask that you don't use external libraries. I like for these files to
be as easy as possible to test, so limiting dependencies is helpful.
