---
title: Hello World in MoonScript
layout: default
---

Welcome to another article in the Hello World series! This time we are looking
to implement Hello World in MoonScript, a language that compiles to Lua.

## MoonScript Background

According to [MoonScript.org][1], MoonScript is a dynamic scripting language that
compiles into Lua. What is Lua? Lua is a powerful, efficient, lightweight,
embeddable scripting language. It supports procedural programming, object-oriented
 programming, functional programming, data-driven programming, and data description.

Back to MoonScript, it gives you the full power of Lua while providing a clean
easy syntax without the keyword noise typically seen in a Lua script. MoonScript
 can either be compiled into Lua, or it can be dynamically compiled and run using
 the moonloader.

How did MoonScript start you may ask? Well, its author [Leaf Corcoran][2] built
MoonScript, started building games with MoonScript, added them to [itch.io][3]—an
online platform for indie games which is also built with MoonScript—then
generalized the code base to a general purpose web framework with both
MoonScript and Lua APIs called Lapis.

At any rate, let’s dig into the implementation.

## Hello World In MoonScript

As you can see here, Hello World in MoonScript has a relatively simple
implementation:

```moonscript
print "Hello, World!"
```

All we have to do is call the built-in Lua function print, and that’s it.
Behind the scenes, the code is compiled into Lua which is, in this case,
exactly the same.

In other cases, it could be different. For instance, we could have an
implementation of some arithmetic which we print to the user:

```moonscript
x = 10
y = 15
z = x + y
print y
```

The code is then compiled into Lua like this:

```lua
local x = 10
local y = 15
local z = x + y
return print(y)
```

How cool is that?

## How to Run the Solution

If your feeling adventurous today, You can quickly install MoonScript using one
of the following methods:

**For Windows users**, you can [try installing the windows binaries][4].

**For Linux users**, install [LuaRocks][5] which is a package manager for Lua modules.
Then run the following command:

```console
luarocks install moonscript
```

With the moon executable and Lua modules on your device, run your .moon file
with this command:

```console
moon ./YOURFILE.moon
```

Also, you can compile your .moon file into Lua by using this command:

```console
moonc ./YOURFILE.moon
```

Alternatively, you can always [run MoonScript using an online compiler][6].

## Sample Programs in Every Language

Viola! There you go. Hello World in MoonScript is done. You can probably tell
that this article is a part of a series. Still, there are plenty of programming
languages to add. If you like the idea, you’re welcome to contribute, share,
or comment.

[1]: https://moonscript.org/
[2]: https://github.com/leafo
[3]: http://itch.io/
[4]: https://github.com/leafo/moonscript/releases/download/win32-v0.5.0/moonscript-187bac54ee5a7450013e9c38e005a0e671b76f45.zip
[5]: https://luarocks.org/
[6]: https://moonscript.org/compiler/
