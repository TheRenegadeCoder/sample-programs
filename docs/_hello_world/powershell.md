---
title: Hello World in PowerShell
layout: default
tags: [powershell]
---

Welcome to a guest installment of the Hello World in Every Language series.
I’m Devin Leaman, otherwise known as Alcha, and I’ll be covering Hello World
in PowerShell, a language that appeared in 2006.

## PowerShell Background

PowerShell is the de facto scripting language for managing Windows machines/servers.
Microsoft has made it quite clear that PowerShell is here to stay and will become
the preferred way to manage Windows servers in the future.

Jeffrey Snover is largely credited as the designer behind the language, while
Bruce Payette and James Truher were also on the project, and in an interview in
2017, Snover explained the motivation behind creating PowerShell:

I’d been driving a bunch of managing changes, and then I originally took the UNIX
tools and made them available on Windows, and then it just didn’t work. Right?
Because there’s a core architectural difference between Windows and Linux. On
Linux, everything’s an ASCII text file, so anything that can manipulate that is
a managing tool. AWK,  grep, sed? Happy days!

I brought those tools available on Windows, and then they didn’t help manage Windows because in Windows, everything’s an API that returns structured data. So, that didn’t help. […] I came up with this idea of PowerShell, and I said, “Hey, we can do this better.”

Originally, PowerShell was to be called Monad and it’s ideas were published in a white paper titled Monad Manifesto. Shortly after releasing the Beta 3 version Microsoft formally renamed Monad to Windows PowerShell, followed by the release candidate 1 version.

PowerShell is now up to version 5.1 for stable builds and the new 6.0 version which was announced in 2016 is in public beta. The largest change in this version is it’s now open-source and will now be called PowerShell Core as it runs on .NET Core as opposed to the .NET Framework which previous versions use.

## Hello World in PowerShell

Enough background, let’s actually get something working 😊

```powershell
Write-Host 'Hello, World!'
```

To execute this code, open a PowerShell console on any Windows machine as it comes installed by default. You’ll see the reply output in the window like so:

TODO: insert image <Hello World Console>

As is the case with most modern scripting languages, getting a Hello World sample running is really easy.

## How to Run the Solution

Instead of running the commands directly within the console though, write your scripts in a file and call the file when necessary. Download a copy of the Hello-World.ps1 file from the repository and open a console.

Now, navigate to wherever you downloaded the script and execute it by calling it like so:

```console
.\Hello-World.ps1
```

This calls the script and returns the output to the console:

TODO: insert image Hello World Script

## Sample Programs in Every Language

Well, there you have it, Hello World in PowerShell. If you liked this article, don’t forget to give it a share, and if you’re interested in contributing, check out the Sample Programs repository. Until next time!
