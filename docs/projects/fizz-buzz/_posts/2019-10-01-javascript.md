---
title: FizzBuzz in JavaScript
layout: default
last-modified: 2020-05-02
featured-image:
tags: [javascript, fizzbuzz]
authors:
  - herrfugbaum
---

FizzBuzz is a simple game played by children. The rules are as follows:

Count until a number _n_ (usually 100) if you encounter a number that is divisible by 3 instead say fizz, if the number is divisible by 5 instead say buzz, if the number is both divisible by 3 and 5 say fizzbuzz instead.

Example:

* 1
* 2
* fizz
* 4
* buzz
* fizz
* 7
* 8
* fizz
* buzz
* 11
* fizz
* 13
* 14
* fizzbuzz
* ...

Let's have a look at how this could be implemented in JavaScript:

## How to Implement the Solution

```javascript
function fizzbuzz(num){
    for(let i=1; i <= num; i++){
      if(i % 15 == 0){
        console.log("fizzbuzz");
      }
      else if(i % 5 == 0){
        console.log("buzz");
      }
      else if(i % 3 == 0){
        console.log("fizz");
      }
      else console.log(i);
   }
  }

fizzbuzz(100);
```

FizzBuzz is quite a simple program.
In line 1 the `fizzbuzz` function gets declared. It takes a parameter `num` that determines how far the program should count.
The counting logic takes place in a for-loop in line 2. It starts counting at 1, increases the counter `ì` by 1 in every iteration and stops once it reaches `num`.

To understand the main logic of this programm you need to know

## The modulo (remainder) operator %

>> The remainder operator returns the remainder left over when one operand is divided by a second operand. It always takes the sign of the dividend. ([Mozilla][1])

The trick here is to create a _truthy_ value for the if statements. This is why you can see the `i % 3 == 0` etc. conditionals. If a number is divisible by 3 there will be no remainder, in other words the remainder is true and thus i % 3 == 0 (% 5, % 15) is true in these cases.

Hint: The order of the conditionals matters. If you'd check for example in reverse order, you would print all 3 strings, if the number is divisible by 3 _and_ 5!

Hint: Instead of `i % 15 == 0` you could also write `i % 3 && i % 5`.

Last but not least it prints the number via the else clause `else console.log(i);` if none of the conditionals were true.

Extra mile: If you want you can move the conditionals into variables and move them up the scope, right after the second line between the for loop and the first if statement.
For example: const divisibleBy3 = i % 3. This way you'd remove the use of [magic numbers][2].

Fun Fact: Despite being a simple programming exercise there is a controversal article about the question [Why can't programmers program?](https://blog.codinghorror.com/why-cant-programmers-program/) that even led to an ["enterprise-class"](https://github.com/EnterpriseQualityCoding/FizzBuzzEnterpriseEdition) version of this game.

## How to Run Solution

### In the Browser

To try out this script just copy it, open the dev tools of your Browser (F12 by default in most cases), head to the `console` tab, paste in the script and press enter to run it.

### Node.js

Download and install Node.js.
Save the script in for example index.js and from the same directory open a console of your choice (cmd, powershell, bash, etc.) and run `node index.js`.
Hint: Depending on your operating system the node binary might be called slightly different for example on some linux distris you'd need to type `nodejs index.js` instead.

## Further Reading

- [Arithmetic Operators][1] on Mozilla
- [Magic Number][2] on Wikipedia

[1]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Arithmetic_Operators#Remainder
[2]: https://en.wikipedia.org/wiki/Magic_number_(programming)
