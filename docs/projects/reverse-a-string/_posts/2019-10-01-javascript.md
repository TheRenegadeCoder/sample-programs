---
title: Reverse a String in JavaScript
layout: default
last-modified: 2020-05-02
featured-image:
tags: [javascript, reverse-a-string, string-reversal]
authors:
  - herrfugbaum
---

In this article, we will examine the Reverse a String in JavaScript problem.

## How to Implement the Solution

Let's look at the code in detail:

```javascript
function reverse(s) {
  return s.split('').reverse().join('');
}

function main() {
  var toReverse = prompt("Enter a String", "Hello, World!");
  if (toReverse != null) {
      console.log(reverse(toReverse))
  }
}

main()
```

First there is a function declaration `reverse` which takes one parameter `s`.
The `reverse` function returns a method chain of the `s` parameter. It assumes that the parameter is of type string. A string in JavaScript offers numerous methods, like `.toLowerCase()` which would mutate a string to all lowercase letters.

Another method of the String object is the `split` method which you can see above.
`split()` takes two optional parameters, a seperator and a limit. In the `reverse` function it is used with an empty string `''` as a seperator. This has the effect of splitting the string at _every_ character. The return value of the `split` method is, and this makes the beauty of this solution, an array, which has it's own methods built in.

If you call the `reverse` function above, for example with 'hello', the split method would return `['h', 'e', 'l', 'l', 'o']`. Since this is an array you can immediately use one of the various array methods available in JavaScript. Luckily the language helps us a lot here, since it already has a method '.reverse()' to reverse an array.

Now we are at the second chained method and our hypothetical output would look like this `['o', 'l', 'l', 'e', 'h']`. We are just one step ahead of our solution.
All we need to do now is to somehow get back to a string. One of the array methods JavaScript offers us is the `.join()` method. It, kind of, is the opposite of the `split` method as it mangles together an array, based on an optional `seperator` parameter and returns a string. Like the in the `split` method an empty string as a parameter means that it will execute on every value in the array. Since we have single characters as values it will simply concatenate them together to our string.

Now our solution is complete.

Let's look at it again, this time written such as that every method call gets on it's own line, so we can write the intermediary values as comments behind them.

Again we assume that the `reverse` function gets called with a string 'hello'.

```javascript
// We call reverse with 'hello'
reverse('hello')
// Let's have a look what happens when the line above gets executed:
function reverse(s) {
  return s
    .split('') // ['h', 'e', 'l', 'l', 'o']
    .reverse() // ['o', 'l', 'l', 'e', 'h']
    .join(''); // 'olleh'
}
```

The rest of the code is technically not needed to reverse the string. The main method is declared and on the last line of the program, called without parameters, as the main function in this example doesn't take any. First it's prompting the user to enter a string by calling the `prompt()` method. The first parameter is a message shown to the user and the second is a default value. Fun fact: The prompt method takes 3 parameters; the third one being the value the user enters!
The value now gets saved into the toReverse variable. The next 3 lines of the program will check if the `toReverse`variable holds any value that is not null and if this is true it will call the `console.log()`method with the `reverse` function which is, again, called with the value that resides in `toReverse`. After the `reverse` function got evaluated, the console.log will print the reversed string to the browsers console.

## How to Run Solution

To run this example you can simply open the dev tools of your browser (F12) in most cases and navigate to the `console` tab.
There you can paste in the code snippet from above.

Alternatively you can view and play around with the script at [jsfiddle.net](https://jsfiddle.net/dbmyxkwz/).
