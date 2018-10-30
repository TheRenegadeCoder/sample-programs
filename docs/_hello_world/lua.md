---
title: Hello World in Lua
layout: default
---

Welcome back to yet another issue of the Hello World in Every Language. It’s
been awhile since I’ve written one of these articles myself, so bear with me!
Today, we’re covering Hello World in Lua, a scripting language from 1993.

## Lua Background

As usual, I’m not super familiar with the language we’re working with today,
so let’s consult [Wikipedia][1].

Like many of the languages we’ve touched on already, Lua is a scripting language.
Unlike many of the scripting languages we’ve covered, Lua is extremely lightweight,
so it shines in embedded applications.

Perhaps the oddest featured of Lua is the fact that it’s compiled, but this is
not readily apparent to the user. That’s because the compilation occurs at
run-time where the bytecode is then interpreted. However, it’s possible to
precompile Lua to save a few CPU cycles during runtime.

Because Lua is built for embedded applications, it has its own C API which can
be used to write Lua code in C. Personally, I don’t find the API to be that
user-friendly, but it does eliminate the need for reference management, so I
can’t really complain.

Due to its lightweight and embedded nature, Lua has also found a home in the
gaming community. How have I never used it?

## Hello World in Lua

At any rate, let’s get down to business:

```lua
print("Hello, World!")
```

As we’ll quickly notice, Hello World in Lua is not that exciting. In fact, there
are only a handful of languages with this boring of an implementation. For
instance, both Ruby and Python can perform Hello World in a similar fashion.
As a result, there’s not a ton of explaining that needs to be done.

Essentially, Lua has a native printing function which can be used to write a
string to stdout. In this case, it’s called print, but the developers could
have just as easily called it put, write, println, or puts. If you know of any
other fun print function names, let me know in the comments.

As usual, we pass a string to the print function, and the function handles the rest.

## How to Run the Solution

Well, perhaps running the script will be more interesting. Fortunately for us,
there’s [an online REPL for Lua][2], so we don’t have to worry about downloading
anything. Once inside, drop the code snippet from above into the editor and hit
run. That’s it!

Alternatively, we could [download a copy of Lua][3], and run the solution locally.
Even better, we could build a Docker image, so we don’t clutter our machine with
dependencies. If you want to help with the Docker initiative, head on over to
the Sample Programs repository and fork it. We appreciate the help!

## Sample Programs in Every Language

As usual, thanks for sticking around to support the series. I appreciate it!

If there’s anyone you know who might like this series, make sure you share it
with them. And if you want to help the series grow, why not head over to the
[Sample Programs repository][4] and make an addition.

At any rate, until next time!

[1]: https://en.wikipedia.org/wiki/Lua_(programming_language)
[2]: https://repl.it/languages/lua
[3]: https://www.lua.org/download.html
[4]: https://github.com/jrg94/sample-programs
