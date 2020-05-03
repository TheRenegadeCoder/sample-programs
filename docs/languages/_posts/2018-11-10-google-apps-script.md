---
title: The Google Apps Script Programming Language
layout: default
last-modified: 2020-05-02
featured-image:
tags: [google-apps-script]
authors:
  - the_renegade_coder
---
According to [Wikipedia][1], Google Apps Script is a scripting language for the G
Suite which includes applications like Gmail, Google Drive, Google Calendar, etc.
In other words, we’re dealing with a domain specific language.

In terms of features, Google Apps Script shares a likeness to [JavaScript][2].
As a result, the language is relatively easy to learn.

That said, there are some limitations. For instance, each script is executed in
the cloud, so their are restrictions such as limiting access to various services.

In addition, working with date/time objects can be challenging as data may cross
time zones during execution. As a result, developers have to be very deliberate
in their scripts.

Overall, Google Apps Script appears to be a great tool for anyone looking to
write add-ons for G Suite applications. Otherwise, you’ll probably never use it.[^1]

## Articles

{% include article_list.md collection=site.tags.google-apps-script %}

## Further Reading

-

---

#### References

[^1]: J. Grifski, “Hello World in Google Apps Script,” The Renegade Coder, 22-May-2018. [Online]. Available: <https://therenegadecoder.com/code/hello-world-in-google-apps-script/>. [Accessed: 10-Nov-2018].

[1]: https://en.wikipedia.org/wiki/Google_Apps_Script
[2]: https://therenegadecoder.com/code/hello-world-in-javascript/
