---
title: Hello World in PowerShell
layout: default
tags: [powershell]
---

![Hello World in PowerShell Featured Image][1]

## Hello World in PowerShell<sup>1</sup>

Let’s get something working! 😊

```powershell
Write-Host 'Hello, World!'
```

To execute this code, open a PowerShell console on any Windows machine as it
comes installed by default. You’ll see the reply output in the window like so:

```console
[20:35:40]:Alcha$ Write-Host 'Hello, World!'
Hello, World!
[20:35:56]:Alcha$
```

As is the case with most modern scripting languages, getting a Hello World
sample running is really easy.

## How to Run the Solution<sup>1</sup>

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

---

#### References

1. D. Leaman, “Hello World in PowerShell,” The Renegade Coder, 28-Jul-2018.
  [Online]. Available: <https://therenegadecoder.com/code/hello-world-in-powershell/>.
  [Accessed: 31-Oct-2018].

[1]: {{site.baseurl}}/assets/hello-world-in-powershell-featured-image.JPEG
