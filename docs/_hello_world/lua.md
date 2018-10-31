---
title: Hello World in Lua
layout: default
---

## Hello World in Lua<sup>1</sup>

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

## How to Run the Solution<sup>1</sup>

Well, perhaps running the script will be more interesting. Fortunately for us,
there’s [an online REPL for Lua][2], so we don’t have to worry about downloading
anything. Once inside, drop the code snippet from above into the editor and hit
run. That’s it!

Alternatively, we could [download a copy of Lua][3], and run the solution locally.
Even better, we could build a Docker image, so we don’t clutter our machine with
dependencies. If you want to help with the Docker initiative, head on over to
the Sample Programs repository and fork it. We appreciate the help!

---

#### References

1. J. Grifski, “Hello World in Lua,” The Renegade Coder, 28-Jul-2018.
  [Online]. Available: <https://therenegadecoder.com/code/hello-world-in-lua/>.
  [Accessed: 31-Oct-2018].

[2]: https://repl.it/languages/lua
[3]: https://www.lua.org/download.html
