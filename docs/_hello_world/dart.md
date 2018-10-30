---
title: Hello World in Dart
layout: default
---

Welcome to yet another community edition of the Hello World in Every Language
series. This time, we have an article brought to you by Stargator. Let’s learn
how to say Hello World in Dart!

## Dart Background

Dart is a general-purpose language that was designed with five goals:

- Productive
  - Dart’s syntax is clear and concise, its tooling simple yet powerful.
  Sound typing helps you to identify subtle errors early. Dart has
  battle-hardened core libraries and an ecosystem of thousands of packages
- Fast
  - Dart provides optimizing ahead-of-time compilation to get predictably
  high performance and fast startup across mobile devices and the web.
- Portable
  - Dart compiles to ARM and x86 code, so that Dart mobile apps can run natively
  on iOS, Android, and beyond. For web apps, Dart compiles to JavaScript.
- Approachable
  - Dart is familiar to many existing developers, thanks to its unsurprising
  object orientation and syntax. If you already know C++, C#, or Java, you can
  be productive with Dart in just a few days.
- Reactive
  - Dart is well-suited to reactive programming, with support for managing
  short-lived objects—such as UI widgets—through Dart’s fast object allocation
  and generational garbage collector. Dart supports asynchronous programming
  through language features and APIs that use Future and Stream objects.

Since its inception, Dart has gone through different phases as Google tried to
sell its potential to developers. Google has rebuilt it’s advertising service
AdSense with Dart. That demonstrate’s Google’s commitment to Dart by depending
on the language for it’s main method of generating revenue.

The language also has many great features like garbage collection and a strong
typing system (as of Dart 2.0). All of it sits on top of a VM like Java, which
allows there to be less configuration between the test side and the source code.
A programmer can just get started from the get-go!

## Hello World in Dart
Coming from a Java background, the following snippet of code is downright
stripped to the barebones.

```dart
void main() => print('Hello, World!');
```

In order to implement Hello World in Dart, developers need to understand only
three concepts like main methods, strings, and arrow functions. But look at the
code above, it seems deceptively easy, right?

What is going on is “main()” only does one thing, print the phrase “Hello, World!”.
We’ll dig into how and why all of this happens in a bit. But it’s important to
step away for a bit and just look at what’s there and acknowledge how simple it is.

In a Dart project, only one class would have a main method (“main()”). A main
method is how every Dart program knows where to start. Therefore, every program
must have exactly one of these main methods implemented. Don’t worry too much
about the syntax. Just know that we need a main method.

Then we have to output our greeting (“Hello, World!”) to the command line. To
do so, we have to leverage a static method out of Dart’s built-in library. It’s
the “print” statement. It’s a method like “main()” only difference is we put a
string inside the parentheses. It tells the computer to take the string and
print out so we can read it.

The last concept are arrow functions (“=>”). These are methods like print or,
in this case, main that only do one thing. Because they only do one thing, we
can use “=>” from the method’s definition (“main()”) directly to the logic.
Other more complex methods may require the use of “return”. But that’s not
required in this case.

## How to Run the Solution

TODO

## Sample Programs in Every Language

And, that’s it. Hello, World in Dart! If you need more information, take a tour
of the Dart language.

As always, you can share your thoughts below in the comments. If you liked
what you saw today, consider sharing it with your friends. And if you’re really
feeling adventurous, why not contribute to the project?
