---
title: Hello World in PowerShell
layout: default
last-modified: 2020-05-02
featured-image: hello-world-in-powershell-featured-image.JPEG
tags: [powershell, hello-world]
authors:
  - alcha
---

Today, we'll be taking on Hello World in [PowerShell][1], a task automation language
built by Microsoft.

## How to Implement the Solution

Let’s get something working! 😊

```powershell
Write-Host 'Hello, World!'
```

To execute this code, open a [PowerShell][1] console on any Windows machine as it
comes installed by default. You’ll see the reply output in the window like so:

```console
[20:35:40]:Alcha$ Write-Host 'Hello, World!'
Hello, World!
[20:35:56]:Alcha$
```

As is the case with most modern scripting languages, getting a Hello World
sample running is really easy.

## How to Run the Solution

Instead of running the commands directly within the console though, write your
scripts in a file and call the file when necessary. Download a copy of the
Hello-World.ps1 file from the repository and open a console.

Now, navigate to wherever you downloaded the script and execute it by calling
it like so:

```console
.\Hello-World.ps1
```

This calls the script and returns the output to the console:

```console
[20:35:40]:powershell$ .\Hello-Wordl.ps1
Hello, World!
[20:35:56]:powershell$
```

And, that's it!

## Further Reading

- [Hello World in Opa][2] on The Renegade Coder

[1]: {{ site.baseurl }}{% post_url /languages/2018-11-01-powershell %}
[2]: https://therenegadecoder.com/code/hello-world-in-powershell/
