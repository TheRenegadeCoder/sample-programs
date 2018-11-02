---
title: Lua
layout: default
tags: [lua]
authors:
  - the_renegade_coder
---

## The Lua Programming Language<sup>1</sup>

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

---

#### References

1. J. Grifski, “Hello World in Lua,” The Renegade Coder, 28-Jul-2018.
  [Online]. Available: <https://therenegadecoder.com/code/hello-world-in-lua/>.
  [Accessed: 31-Oct-2018].

[1]: https://en.wikipedia.org/wiki/Lua_(programming_language)
