---
title: PowerShell
layout: default
date: 2018-11-01
last-modified: 2018-11-01
tags: [powershell]
authors:
  - alcha
---

## The PowerShell Programming Language<sup>1</sup>

PowerShell is the de facto scripting language for managing Windows machines/servers.
[Microsoft][2] has made it quite clear that PowerShell is here to stay and will become
the preferred way to manage Windows servers in the future.

[Jeffrey Snover][1] is largely credited as the designer behind the language, while
Bruce Payette and James Truher were also on the project, and in an interview in
2017, Snover explained the motivation behind creating PowerShell:<sup>2</sup>

    I’d been driving a bunch of managing changes, and then I originally took the UNIX
    tools and made them available on Windows, and then it just didn’t work. Right?
    Because there’s a core architectural difference between Windows and Linux. On
    Linux, everything’s an ASCII text file, so anything that can manipulate that is
    a managing tool. AWK, grep, sed? Happy days!

    I brought those tools available on Windows, and then they didn’t help manage Windows
    because in Windows, everything’s an API that returns structured data. So, that
    didn’t help. […] I came up with this idea of PowerShell, and I said, “Hey,
    we can do this better.”

Originally, PowerShell was to be called Monad and it’s ideas were published in a
white paper titled [Monad Manifesto][3]. Shortly after releasing the Beta 3 version
Microsoft formally renamed Monad to Windows PowerShell, followed by the release
candidate 1 version.

PowerShell is now up to version 5.1 for stable builds and the new 6.0 version
which was announced in 2016 is in public beta. The largest change in this version
is it’s now open-source and will now be called PowerShell Core as it runs on
[.NET Core][4] as opposed to the [.NET Framework][5] which previous versions use.<sup>3</sup>

---

#### References

1. D. Leaman, “Hello World in PowerShell,” The Renegade Coder, 28-Jul-2018.
  [Online]. Available: <https://therenegadecoder.com/code/hello-world-in-powershell/>.
  [Accessed: 31-Oct-2018].
2. “To Be Continuous | Ep. #37, The Man Behind Windows PowerShell,” Heavybit,
  14-Sep-2017. [Online]. Available: <https://www.heavybit.com/library/podcasts/to-be-continuous/ep-37-the-man-behind-windows-powershell/>.
  [Accessed: 31-Oct-2018].
3. “PowerShell is Microsofts latest open source release, coming to Linux, OS X,”
  Ars Technica, 18-Aug-2016. [Online]. Available: <https://arstechnica.com/information-technology/2016/08/powershell-is-microsofts-latest-open-source-release-coming-to-linux-os-x/>.
  [Accessed: 31-Oct-2018].

[1]: https://en.wikipedia.org/wiki/Jeffrey_Snover
[2]: https://www.microsoft.com/
[3]: https://blogs.msdn.microsoft.com/powershell/2007/03/18/monad-manifesto-the-origin-of-windows-powershell/
[4]: https://www.microsoft.com/net/download
[5]: https://www.microsoft.com/net/learn/architecture
