---
title: Hello World in Google Apps Script
layout: default
last-modified: 2020-05-02
featured-image: hello-world-in-google-apps-script-featured-image.JPEG
tags: [google-apps-script, hello-world]
authors:
  - the_renegade_coder
---

In this article, we'll tackle Hello World in Google Apps Script, an application language
developed by Google.

## How to Implement the Solution

At any rate, here’s the implementation of Hello World in Google Apps Script:

```
function helloWorld() {
  Logger.log("Hello, World!");
}
```

Unlike many languages, Google Apps Script code doesn’t need a main function. In fact, all we have to do is define a function. Google handles what we want to do with the script at runtime.

With that in mind, we can see that we’ve defined a helloWorld function with syntax similar to [JavaScript][1]. In other words, we have a function definition which encloses a code block with braces.

Inside the code block, we have our typical print call. In this case, we leverage the Logger to do our printing. Then we pass our “Hello, World!” string to the log function, and call it a day.

## How to Run the Solution

If we want to run Hello World in Google Apps Script, we actually have to write our scripts using the [Apps Script tool][2]. From there, [Google has some nice documentation][3] for running them.

Alternatively, we can write scripts locally and upload them to Google Drive. At that point, we can connect the Google Apps Script tool to run our scripts. The link above has directions for that option as well.

If you know of other ways to run Google Apps Script code, let me know in the comments.

## Further Reading

- [Hello World in Google Apps Script][4] on The Renegade Coder

[1]: https://therenegadecoder.com/code/hello-world-in-javascript/
[2]: https://www.google.com/script/start/
[3]: https://developers.google.com/apps-script/guides/standalone
[4]: https://therenegadecoder.com/code/hello-world-in-google-apps-script/
