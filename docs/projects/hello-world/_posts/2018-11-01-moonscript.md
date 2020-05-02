---
title: Hello World in MoonScript
layout: default
last-modified: 2020-05-02
featured-image: hello-world-in-moonscript-featured-image.JPEG
tags: [moonscript, hello-world]
authors:
  - bassem_mohamed
---

In this article, we'll cover Hello World in MoonScript, a niche scripting
language that compiles to Lua.

## How to Implement the Solution

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

## Further Reading

- [Hello World in MoonScript][1] on The Renegade Coder

[1]: https://therenegadecoder.com/code/hello-world-in-moonscript/
[4]: https://github.com/leafo/moonscript/releases/download/win32-v0.5.0/moonscript-187bac54ee5a7450013e9c38e005a0e671b76f45.zip
[5]: https://luarocks.org/
[6]: https://moonscript.org/compiler/
