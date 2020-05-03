---
title: The PowerShell Programming Language
layout: default
last-modified: 2020-05-02
tags: [powershell]
authors:
  - alcha
---

PowerShell is the de facto scripting language for managing Windows machines/servers.
[Microsoft][2] has made it quite clear that PowerShell is here to stay and will become
the preferred way to manage Windows servers in the future.

[Jeffrey Snover][1] is largely credited as the designer behind the language, while
Bruce Payette and James Truher were also on the project, and in an interview in
2017, [Snover explained the motivation behind creating PowerShell][7]:

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
which was announced in [2016 is in public beta][8]. The largest change in this version
is it’s now open-source and will now be called PowerShell Core as it runs on
[.NET Core][4] as opposed to the [.NET Framework][5] which previous versions use.[^3]

## Articles

{% include article_list.md collection=site.tags.powershell %}

## Further Reading

-

[1]: https://en.wikipedia.org/wiki/Jeffrey_Snover
[2]: https://www.microsoft.com/
[3]: https://blogs.msdn.microsoft.com/powershell/2007/03/18/monad-manifesto-the-origin-of-windows-powershell/
[4]: https://www.microsoft.com/net/download
[5]: https://www.microsoft.com/net/learn/architecture
[6]: https://therenegadecoder.com/code/hello-world-in-powershell/
[7]: https://www.heavybit.com/library/podcasts/to-be-continuous/ep-37-the-man-behind-windows-powershell/
[8]: https://arstechnica.com/information-technology/2016/08/powershell-is-microsofts-latest-open-source-release-coming-to-linux-os-x/
