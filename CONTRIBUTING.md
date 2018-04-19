# Contribute

The goal of this project is to provide a variety of code snippets
for as many languages as possible.

## General Rules

If you wish to contribute, simply fork the repo and make a pull request
with your changes. Your contribution should ideally be in one of two forms:

1. An additional language(s) for an existing sample program (i.e. Hello World)
2. An additional sample program for an existing language(s) (i.e. Perl)

The following list contains all existing sample programs:

1. [Hello World in Every Language](https://therenegadecoder.com/code/hello-world-in-every-language/)
2. [Reverse a String in Every Language](https://therenegadecoder.com/code/reverse-a-string-in-every-language/)

If you create a sample program that is not in this list, please provide the
solution for at least *five* languages to kickstart development.

Otherwise, let's have some fun!

## Hello World Rules

Hello World is a standard program used to introduce a programming language.
As a result, the rules are pretty simple. For each language, create a program
that writes the string "Hello, World!" to standard output. Ideally, the solution
should be as simple as possible.

## Reverse a String Rules

While Hello World is simple, it often does not show off many interesting
features of a language. Fortunately, this repository shares more samples than
Hello World. One of these more complex programs is known as Reverse a String.

Despite the explicit name, there are some rules in place for consistency.
When writing a Reverse a String program, the following rules should apply:

1. The implementation must be executable
2. The string to be reversed must come from the command line
3. The program must verify the strings existence on the command line
4. The user must not import libraries to obfuscate the string manipulation

In other words, the program should get a string from the command line and
reverse it using language utilities only. For example, in Java, StringBuilder
would not be an appropriate library for the Reverse a String task. Meanwhile,
in Python, slices would be appropriate as they're features of the language.

The goal here is to demonstrate language features through IO and string
manipulation, not library support. That said, it is possible that not all
languages will be able to conform to these rules. In those cases, exceptions
can be made.
