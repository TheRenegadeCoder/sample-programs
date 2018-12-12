---
title: Fizz Buzz in PowerShell
layout: default
last-modified: 2018-12-11
featured-image:
tags: [powershell, fizz-buzz]
authors:
  - martyav
---

## How to Implement the Solution

I’m going to start with a little anecdote before getting started on the meaty
portion of this article so feel free to skip ahead to No More Anecdote if you’re
just not that interested 😅 I completely understand.

I realized about two weeks ago that I hadn’t written anything in a while and had
a bit of a desire to write, with nothing coming to mind on what to write. I was
also dealing with a nagging feeling in my brain of “Should I really write another
article?” and if I did “Who really cares if I write another article? There are
countless others writing about the same stuff”, among other negative thoughts.

I went to a get together with some of my best friends to eat tacos, drink some
tequila, and just enjoy each others company. While I was there, one of my more
technically oriented friends came up to me and we began talking about my work,
playing Overwatch, and other nerdy things, when he mentions to me that he enjoyed
reading my past articles. While he may not be a currently active developer and
that some of the stuff goes over his head, I’ve “got a knack for it” as he said.

> Tron that are heavily requested by the user base. It was enough to remind me the
> whole reason I started writing these is for the off-chance that someone like that
> would enjoy my writing and possibly get them more interested in programming, learn
> something new, or simply enjoy the read for the sake of reading something interesting.

In the end, I’d like to say thank you again to that friend of mine for the
encouraging words, as I probably wouldn’t have had the motivation to start on
this without them 💗

### No More Anecdote

Photo by Raj Eiamworakul on Unsplash

And now we’re off to the juicy bits of the article! 🤤 If you’re unfamiliar with
the Fizz Buzz interview problem, it’s a relatively simple problem that is adept
at testing your knowledge and fundamental understanding of a given programming
language as well as showing the interviewer what kind of developer you are.

For example, do you prefer to toss a bunch of things at the wall and see what
works and whittle away the excess? Or do you prefer to lay out a plan for the
program before you even write some code? If you’d like more information on the
things interviewers can glean from a Fizz Buzz solution, feel free to check out
this article from Lionell Pack on Forbes.

### What’s The Problem?

The actual problem was (from what I can tell, please correct me if I’m wrong)
initially put forth by Imron Ghory over on his blog and it was based on a “group
word game for children to teach them about division.” While there’s a number of
different ways to word this problem, here’s the wording we’re going to be working
with:

> Write a program that prints the numbers 1 to 100. However, for multiples of
> three, print “Fizz” instead of the number. Meanwhile, for multiples of five,
> print “buzz” instead of the number. For numbers which are multiples of both,
> print “FizzBuzz.”

This means there are a few things we need to keep in mind or consider:

The minimum value of 1.
The maximum value of 100.
Determine which order to check for multiples to avoid missing edge cases.
Write the output to the console.
Where to Start?
Well, this is where it varies for everyone. Depending on how you tend to work
as a developer, your entry point will vary. Personally, I’ll be starting by
creating the for loop that will iterate through all the numbers we need to analyze.
This starts us off with something like the following for PowerShell:

```powershell
for ($x = 1; $x -le 100; $x++) {
  Write-Output $x
}
```

This will get us a starting point of outputting every number from 1 to 100. Now
we should start putting in some if statements to determine if $x is a multiple
of 3, 5, or both. As is the case with most modern programming languages, PowerShell
has a modulus operator that will return the remainder of the division between two
numbers.

For example, doing Write-Output (25 % 5) would output 0, since 25 divided by 5
has no remainder. This also happens to mean the first value is a multiple of
the second, which we can use to determine the multiples of $x. When I first
wrote this script, my solution looked like so:

```powershell
for($x = 1; $x -le 100; $x++) {
  $Threes = $x%3
  $Fives = $x%5
  if (($Threes -eq 0) -and ($Fives -eq 0)) {
    Write-Output"FizzBuzz"
  } else if ($Threes -eq 0) {
    Write-Output"Fizz"
  } else if ($Fives -eq 0) {
    Write-Output"Buzz"
  } else {
    Write-Output$x
  }
}
```

### Cleaning Up Our First Draft

While this works, it’s a bit clunky and doesn’t allow for us to easily modify it
in the future if we want to add cases other than being a multiple of 3 or 5. I
hadn’t quite realized this until I went looking for more information on this
problem and found a video by Tom Scott. He pointed out that you could easily
account for future adjustments by combining the output as a single variable for
each number.

While he used JavaScript, the solution should be easily understandable and looks
like so:

```powershell
for (var i = 1; i <= 100; i++) {
  var output = ""
  if (i % 3 === 0) output += "Fizz"
  if (i % 5 === 0) output += "Buzz"
  if (output === "") output = i
  console.log(output)
}
```

As you can see, he creates the output variable for each iteration of $x and
depending on the multiples, adds or replaces values to that variable. Then, in
the end, he outputs it to the console using console.log.

Translating this to PowerShell, we get something like so:

```powershell
for ($x = 1; $x -le 100; $x++) {
  $Output = ""
  if ($x%3 -eq 0) { $Output += "Fizz" }
  if ($x%5 -eq 0) { $Output += "Buzz" }
  if ($Output -eq "") { $Output = $x }
  Write-Output $Output
}
```

At this point, we have a working solution to the Fizz Buzz problem written in
PowerShell. If you were to copy and paste it into a terminal you’d get something
that looks like this:

PowerShell FizzBuzz Script Output

The default output of the FizzBuzz script written in PowerShell.

### Finally, A Script!

Now, since this is PowerShell, it’s no fun just having a for loop that we need
to copy paste. No, we need a script! 😈

I created a file simply titled FizzBuzz.ps1 and got to work by adding the standard
goodies at the top of a PowerShell script:

```powershell
[CmdletBinding()]
param ()
```

Since I was initially writing this script for the sample programs repository I
contribute to, I knew I wanted to support more than going from 1 to 100. Instead,
I wanted users to be able to provide a minimum and maximum parameter that would
let them modify the output. This simply means adding two parameters to the param
() field like so:

```powershell
param (
  [Parameter(Mandatory = $false, Position = 0)]
  $Min = 1,
  [Parameter(Mandatory = $false, Position = 1)]
  $Max = 100
)
```

The Mandatory and Position attributes tell PowerShell that the parameters have
default values and that they aren’t mandatory, and the position attribute makes
it possible to do something like .\FizzBuzz.ps1 0 75 to adjust the min and max
without having to specify the parameter names. Then, with some minor changes to
the for loop, we have our finished result!

```powershell
<#
.SYNOPSIS
  A simple script that solves the standard FizzBuzz interview problem.
.DESCRIPTION
  A simple script that solves the FizzBuzz interview problem to illustrate flow
control within a PowerShell script.
.PARAMETER Min
  The minimium value to start counting at (inclusive). Defaults to 1.
.PARAMETER Max
  The maximum value to count to (inclusive). Defaults to 100.
.EXAMPLE
  .\FizzBuzz.ps1
1
2
Fizz
4
Buzz
[[[Fizz][0]][0]][0]
...
.EXAMPLE
  .\FizzBuzz.ps1 -Min 10 -Max 75
Buzz
11
Fizz
13
14
FizzBuzz
16
...
.NOTES
  For reference, here's a copy of the FizzBuzz problem that this script solves,
the only difference between the requested solution and this script is the script
will let you determine the minimum and maximum values if you desire:
"Write a program that prints the numbers 1 to 100. However, for multiples of
three, print "Fizz" instead of the number. Meanwhile, for multiples of five,
print "Buzz" instead of the number. For numbers which are multiples of both,
print "FizzBuzz"
#>
[CmdletBinding()]
param (
  [Parameter(Mandatory = $false, Position = 0)]
  $Min = 1,
  [Parameter(Mandatory = $false, Position = 1)]
  $Max = 100
)
for ($X = $Min; $X -le $Max; $X++) {
  $Output = ""
  if ($X % 3 -eq 0) { $Output += "Fizz" }
  if ($X % 5 -eq 0) { $Output += "Buzz" }
  if ($Output -eq "") { $Output = $X }
  Write-Output $Output
}
```

## How to Run the Solution

To run the Fizz Buzz script, launch a PowerShell console, grab a copy of the
Fizz Buzz script from the repository (or copy/paste the code from above 😉),
and then execute it.

NOTE: If you have a secure Execution Policy, you’ll have to set it to unrestricted
before executing this script.

```powershell
$Url = "https://raw.githubusercontent.com/TheRenegadeCoder/sample-programs/master/archive/p/powershell/FizzBuzz.ps1"
$CurrPath = (Get-Location).Path
$FilePath = "$CurrPath\FizzBuzz.ps1"
$WebClient = New-Object System.Net.WebClient
$WebClient.DownloadFile($Url, $FilePath)
# Only use option 2 if you're unable to execute the script due to an ExecutionPolicy restriction.
# Afterward, reconfigure your policy to something more secure, such as options 2 or 3.
#
# Option 1:
# Set-ExecutionPolicy Unrestricted
#
# Option 2:
# Set-ExecutionPolicy AllSigned
#
# Option 3:
# Set-ExecutionPolicy RemoteSigned
.\FizzBuzz.ps1
# Output:
# 1
# 2
# Fizz
# 4
# Buzz
# Fizz
# 7
# 8
# Fizz
# Buzz
# 11
# Fizz
```
